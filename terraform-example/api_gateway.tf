resource "aws_api_gateway_stage" "api_gateway" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  deployment_id = aws_api_gateway_deployment.api_gateway.id
}

resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = "Approval-${random_id.random.hex}"
  description = "MEGAZONE CLOUD Hands-on"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "api_gateway" {
  depends_on  = [aws_api_gateway_integration.api_gateway]
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = "dev"
}

resource "aws_api_gateway_resource" "api_gateway" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "myapi_gatewayresource"
}

resource "aws_api_gateway_method" "api_gateway" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method_settings" "s" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = aws_api_gateway_stage.api_gateway.stage_name
  method_path = "${aws_api_gateway_resource.api_gateway.path_part}/${aws_api_gateway_method.api_gateway.http_method}"

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
  }
}

resource "aws_api_gateway_integration" "api_gateway" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.api_gateway.id
  http_method             = aws_api_gateway_method.api_gateway.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.ApprovalHandler.invoke_arn
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ApprovalHandler.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.region}:${var.accountId}:${aws_api_gateway_rest_api.api_gateway.id}/*/${aws_api_gateway_method.api_gateway.http_method}${aws_api_gateway_resource.api_gateway.path}"
}
