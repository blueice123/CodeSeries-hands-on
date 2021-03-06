resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda-${random_id.random.hex}"

  assume_role_policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  EOF
}

resource "aws_iam_role_policy" "mz_hands-on_lambda" {
  name = "mz_hands-on_lambda-${random_id.random.hex}"
  role = aws_iam_role.iam_for_lambda.id

  policy = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "logs:CreateLogGroup",
                    "logs:CreateLogStream",
                    "logs:PutLogEvents"
                ],
                "Resource": "*"
            },
            {
            "Action": [
                "codepipeline:GetPipeline",
                "codepipeline:GetPipelineState",
                "codepipeline:GetPipelineExecution",
                "codepipeline:ListPipelineExecutions",
                "codepipeline:ListPipelines",
                "codepipeline:PutApprovalResult"
            ],
                "Effect": "Allow",
                "Resource": "*"
            }
        ]
    }
  EOF
}


## Function of Approval Requester 
resource "aws_lambda_function" "ApprovalRequester" {
  filename      = "script/ApprovalRequester.zip"
  function_name = "ApprovalRequester-${random_id.random.hex}"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "ApprovalRequester.Requester"
  timeout       = "300"
  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("script/ApprovalRequester.zip")

  runtime = "python3.8"

  environment {
    variables = {
        SLACK_WEBHOOK_URL = var.SLACK_WEBHOOK_URL,
        SLACK_CHANNEL     = var.SLACK_CHANNEL
    }
  }
}

## Refrence in https://medium.com/faun/deploy-merge-and-build-code-from-slack-in-aws-125507c85765
## https://api.slack.com/apps -> Create New App
## Function of Approval Handler 
resource "aws_lambda_function" "ApprovalHandler" {
  filename      = "script/ApprovalHandler.zip"
  function_name = "ApprovalHandler-${random_id.random.hex}"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "ApprovalHandler.Handler"
  timeout       = "300"
  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("script/ApprovalHandler.zip")

  runtime = "python3.8"

  environment {
    variables = {
        SLACK_VERIFICATION_TOKEN	 = var.SLACK_VERIFICATION_TOKEN	
    }
  }
}

## Create SNS
resource "aws_sns_topic" "Approval_Request_SNS" {
  name = "approval-request-topic-${random_id.random.hex}"
}

## Connect backend to Lambda 
resource "aws_sns_topic_subscription" "Approval_Request_SNS" {
  topic_arn = aws_sns_topic.Approval_Request_SNS.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.ApprovalRequester.arn
}
resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ApprovalRequester.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.Approval_Request_SNS.arn
}