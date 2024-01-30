resource "aws_dynamodb_table" "device_data" {
  name           = "DeviceData"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "DeviceID"

  attribute {
    name = "DeviceID"
    type = "S"
  }
}