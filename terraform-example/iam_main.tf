## Create IAM role for EC2 
resource "aws_iam_role_policy" "mz_hands-on_ssm" {
  name = "mz_hands-on_ssm-${random_id.random.hex}"
  role = aws_iam_role.mz_hands-on_ssm.id

  policy = <<-EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:DescribeDocument",
                "ssm:GetManifest",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:PutComplianceItems",
                "ssm:PutConfigurePackageResult",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutMetricData"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstanceStatus"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketLocation",
                "s3:GetObject",
                "s3:GetEncryptionConfiguration",
                "s3:AbortMultipartUpload",
                "s3:ListBucket"
            ],
            "Resource": "*"
        }
     ]
    }
  EOF
}
resource "aws_iam_instance_profile" "mz_hands-on_ssm" {
  name = "mz_hands-on_ssm-${random_id.random.hex}"
  role = aws_iam_role.mz_hands-on_ssm.name
}
resource "aws_iam_role" "mz_hands-on_ssm" {
  name = "mz_hands-on_ssm-${random_id.random.hex}"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  }
  EOF
}

## Create IAM role for CodeDeploy
resource "aws_iam_role_policy" "mz_hands-on_codedeploy" {
  name = "mz_hands-on_codedeploy-${random_id.random.hex}"
  role = aws_iam_role.mz_hands-on_codedeploy.id

  policy = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "autoscaling:CompleteLifecycleAction",
                    "autoscaling:DeleteLifecycleHook",
                    "autoscaling:DescribeAutoScalingGroups",
                    "autoscaling:DescribeLifecycleHooks",
                    "autoscaling:PutLifecycleHook",
                    "autoscaling:RecordLifecycleActionHeartbeat",
                    "autoscaling:CreateAutoScalingGroup",
                    "autoscaling:UpdateAutoScalingGroup",
                    "autoscaling:EnableMetricsCollection",
                    "autoscaling:DescribeAutoScalingGroups",
                    "autoscaling:DescribePolicies",
                    "autoscaling:DescribeScheduledActions",
                    "autoscaling:DescribeNotificationConfigurations",
                    "autoscaling:DescribeLifecycleHooks",
                    "autoscaling:SuspendProcesses",
                    "autoscaling:ResumeProcesses",
                    "autoscaling:AttachLoadBalancers",
                    "autoscaling:AttachLoadBalancerTargetGroups",
                    "autoscaling:PutScalingPolicy",
                    "autoscaling:PutScheduledUpdateGroupAction",
                    "autoscaling:PutNotificationConfiguration",
                    "autoscaling:PutLifecycleHook",
                    "autoscaling:DescribeScalingActivities",
                    "autoscaling:DeleteAutoScalingGroup",
                    "ec2:DescribeInstances",
                    "ec2:DescribeInstanceStatus",
                    "ec2:TerminateInstances",
                    "tag:GetResources",
                    "sns:Publish",
                    "cloudwatch:DescribeAlarms",
                    "cloudwatch:PutMetricAlarm",
                    "elasticloadbalancing:DescribeLoadBalancers",
                    "elasticloadbalancing:DescribeInstanceHealth",
                    "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                    "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
                    "elasticloadbalancing:DescribeTargetGroups",
                    "elasticloadbalancing:DescribeTargetHealth",
                    "elasticloadbalancing:RegisterTargets",
                    "elasticloadbalancing:DeregisterTargets"
                ],
                "Resource": "*"
            }
        ]
    }
  EOF
}

resource "aws_iam_role" "mz_hands-on_codedeploy" {
  name = "mz_hands-on_codedeploy-${random_id.random.hex}"
  assume_role_policy = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "",
                "Effect": "Allow",
                "Principal": {
                    "Service": [
                        "codedeploy.amazonaws.com"
                    ]
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
  EOF
}

## Create IAM role for CodePipeline
resource "aws_iam_role_policy" "mz_hands-on_codepipeline" {
  name = "mz_hands-on_codepipeline-${random_id.random.hex}"
  role = aws_iam_role.mz_hands-on_codepipeline.id

  policy = <<-EOF
    {
        "Statement": [
            {
                "Action": [
                    "iam:PassRole"
                ],
                "Resource": "*",
                "Effect": "Allow",
                "Condition": {
                    "StringEqualsIfExists": {
                        "iam:PassedToService": [
                            "cloudformation.amazonaws.com",
                            "elasticbeanstalk.amazonaws.com",
                            "ec2.amazonaws.com",
                            "ecs-tasks.amazonaws.com"
                        ]
                    }
                }
            },
            {
                "Action": [
                    "codecommit:CancelUploadArchive",
                    "codecommit:GetBranch",
                    "codecommit:GetCommit",
                    "codecommit:GetUploadArchiveStatus",
                    "codecommit:UploadArchive"
                ],
                "Resource": "*",
                "Effect": "Allow"
            },
            {
                "Action": [
                    "codedeploy:CreateDeployment",
                    "codedeploy:GetApplication",
                    "codedeploy:GetApplicationRevision",
                    "codedeploy:GetDeployment",
                    "codedeploy:GetDeploymentConfig",
                    "codedeploy:RegisterApplicationRevision"
                ],
                "Resource": "*",
                "Effect": "Allow"
            },
            {
                "Action": [
                    "elasticbeanstalk:*",
                    "ec2:*",
                    "elasticloadbalancing:*",
                    "autoscaling:*",
                    "cloudwatch:*",
                    "s3:*",
                    "sns:*",
                    "cloudformation:*",
                    "rds:*",
                    "sqs:*",
                    "ecs:*"
                ],
                "Resource": "*",
                "Effect": "Allow"
            },
            {
                "Action": [
                    "lambda:InvokeFunction",
                    "lambda:ListFunctions"
                ],
                "Resource": "*",
                "Effect": "Allow"
            },
            {
                "Action": [
                    "opsworks:CreateDeployment",
                    "opsworks:DescribeApps",
                    "opsworks:DescribeCommands",
                    "opsworks:DescribeDeployments",
                    "opsworks:DescribeInstances",
                    "opsworks:DescribeStacks",
                    "opsworks:UpdateApp",
                    "opsworks:UpdateStack"
                ],
                "Resource": "*",
                "Effect": "Allow"
            },
            {
                "Action": [
                    "cloudformation:CreateStack",
                    "cloudformation:DeleteStack",
                    "cloudformation:DescribeStacks",
                    "cloudformation:UpdateStack",
                    "cloudformation:CreateChangeSet",
                    "cloudformation:DeleteChangeSet",
                    "cloudformation:DescribeChangeSet",
                    "cloudformation:ExecuteChangeSet",
                    "cloudformation:SetStackPolicy",
                    "cloudformation:ValidateTemplate"
                ],
                "Resource": "*",
                "Effect": "Allow"
            },
            {
                "Action": [
                    "codebuild:BatchGetBuilds",
                    "codebuild:StartBuild"
                ],
                "Resource": "*",
                "Effect": "Allow"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "devicefarm:ListProjects",
                    "devicefarm:ListDevicePools",
                    "devicefarm:GetRun",
                    "devicefarm:GetUpload",
                    "devicefarm:CreateUpload",
                    "devicefarm:ScheduleRun"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "servicecatalog:ListProvisioningArtifacts",
                    "servicecatalog:CreateProvisioningArtifact",
                    "servicecatalog:DescribeProvisioningArtifact",
                    "servicecatalog:DeleteProvisioningArtifact",
                    "servicecatalog:UpdateProduct"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "cloudformation:ValidateTemplate"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ecr:DescribeImages"
                ],
                "Resource": "*"
            }
        ],
        "Version": "2012-10-17"
    }
  EOF
}

resource "aws_iam_role" "mz_hands-on_codepipeline" {
  name = "mz_hands-on_codepipeline-${random_id.random.hex}"
  assume_role_policy = <<-EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "codepipeline.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
    }
  EOF
}