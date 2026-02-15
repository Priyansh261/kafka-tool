terraform {
  backend "s3" {
    bucket         = "kafka-terraform-test-buckets"
    key            = "terraform/terraform.tfstate"
    region         = "ap-northeast-3"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
