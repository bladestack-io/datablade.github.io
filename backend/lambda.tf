resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

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

resource "aws_lambda_function" "data_capture_function" {
  function_name = "DataCaptureFunction"

  # Replace with the path to your Lambda deployment package
  filename      = "./lambda/lambda.zip"
  handler       = "index.handler" # Update handler accordingly
  role          = aws_iam_role.lambda_role.arn
  runtime       = "nodejs14.x" # Ensure this matches your Lambda's runtime

  source_code_hash = filebase64sha256("./lambda/lambda.zip")
}

# Add necessary permissions and attach them to the role
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
