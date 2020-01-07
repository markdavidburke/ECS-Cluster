

data "aws_region" "current" {}

terraform {
  backend "s3" {
    bucket = "bharath-test-terraform-remote-state"
    key = "test"
    dynamodb_table = "bharath-test-terraform-remote-state-locks"
    region = "us-east-1"
  }
}
