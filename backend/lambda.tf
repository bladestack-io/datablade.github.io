# AWS Lambda Execution Role
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
      },
    ],
  })
}

# Attach the AWS managed basic execution role to the Lambda function
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Policy for DynamoDB Access
resource "aws_iam_policy" "dynamodb_access" {
  name        = "DynamoDBAccessForLambda"
  description = "Allow Lambda function to access DynamoDB table"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:DeleteItem"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:dynamodb:us-east-1:028457440238:table/DeviceData"
      },
    ],
  })
}

# Attach DynamoDB Access Policy to the Lambda Execution Role
resource "aws_iam_role_policy_attachment" "dynamodb_access_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowMyAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.data_capture_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*"
}

# AWS Lambda Function
resource "aws_lambda_function" "data_capture_function" {
  function_name    = "DataCaptureFunction"
  filename         = "./lambda/lambda.zip"
  handler          = "index.handler"
  role             = aws_iam_role.lambda_role.arn
  runtime          = "nodejs20.x"
  source_code_hash = filebase64sha256("./lambda/lambda.zip")
}

# CloudWatch Log Group for the Lambda Function
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.data_capture_function.function_name}"
  retention_in_days = 14
}
