terraform {
    backend "s3" {
    bucket         = "bsio-engineering-us-east-1-tf-state"
    region         = "us-east-1"
    key            = "aim-high-datablade-us-east-1.tfstate"
    dynamodb_table = "bsio-engineering-us-east-1-tf-state-lock"
    encrypt        = true
  }
}