resource "aws_api_gateway_rest_api" "api" {
  name        = "DataCaptureAPI"
  description = "API for capturing device data"
}

resource "aws_api_gateway_resource" "api_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "capture" # Change as needed
}

resource "aws_api_gateway_method" "api_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.api_resource.id
  http_method = aws_api_gateway_method.api_post_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.data_capture_function.invoke_arn
}

resource "aws_api_gateway_method_response" "CORSPostResponse" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.api_resource.id
  http_method = aws_api_gateway_method.api_post_method.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    # "method.response.header.Access-Control-Allow-Methods" = true
    # "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_integration_response" "CORSPostIntegrationResponse" {
  depends_on  = [aws_api_gateway_integration.lambda_integration]
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.api_resource.id
  http_method = aws_api_gateway_method.api_post_method.http_method
  status_code = aws_api_gateway_method_response.CORSPostResponse.status_code

  response_parameters = {
    # "method.response.header.Access-Control-Allow-Origin"  = "'${var.website_url}'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    # "method.response.header.Access-Control-Allow-Methods" = "'POST'"
    # "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
  }

  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_method" "options_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.api_resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "options_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.api_resource.id
  http_method = aws_api_gateway_method.options_method.http_method

  type                    = "MOCK"
  request_templates       = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_integration_response" "options_integration_response" {
  depends_on  = [aws_api_gateway_integration.options_integration]
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.api_resource.id
  http_method = aws_api_gateway_method.options_method.http_method
  status_code = aws_api_gateway_method_response.CORSPostResponse.status_code

  response_parameters = {
    # "method.response.header.Access-Control-Allow-Origin"  = "'${var.website_url}'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
  }

}

resource "aws_api_gateway_method_response" "options_method_response" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.api_resource.id
  http_method = aws_api_gateway_method.options_method.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin"  = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration,
    aws_api_gateway_integration.options_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
}

output "api_endpoint" {
  value = "${aws_api_gateway_rest_api.api.execution_arn}/prod/capture"
}