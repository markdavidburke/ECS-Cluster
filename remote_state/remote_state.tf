
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "bharath_tf_state_store" {
  bucket = "bharath-test-terraform-remote-state"

  # Prevent Accedental Delete of this bucket
  lifecycle {
    prevent_destroy = true
  }
  # Enables versioning
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "bharaths-terraform-locks" {
  hash_key = "LockID"
  name = "bharath-test-terraform-remote-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}

output "bharath_s3_backend_arn" {
  value = aws_s3_bucket.bharath_tf_state_store.arn
  description = "The S3 Bucket ARN"
}

output "bharath_dynamodb_table_name" {
  value = aws_dynamodb_table.bharaths-terraform-locks.name
  description = "The Name of the Dynamo DB table"
}