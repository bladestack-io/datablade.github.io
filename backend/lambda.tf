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
# This allows the function to create and write to CloudWatch log groups
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# AWS Lambda Function
resource "aws_lambda_function" "data_capture_function" {
  function_name = "DataCaptureFunction"
  filename      = "./lambda/lambda.zip"
  handler       = "index.handler"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "nodejs20.x"

  source_code_hash = filebase64sha256("./lambda/lambda.zip")
}

# CloudWatch Log Group for the Lambda Function
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.data_capture_function.function_name}"
  retention_in_days = 14
}
