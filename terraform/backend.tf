terraform {
  backend "s3" {
    bucket = "terraform-jenkins-task"
    key    = "terraform.tfstat"
    region = "us-east-1"   # Default region, will be overridden by the region variable
    dynamodb_table = "state-lock"
  }
}
