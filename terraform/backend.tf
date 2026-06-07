terraform {
  backend "s3" {
    bucket = "project-bedrock-tfstate-805711586344"
    key    = "project-bedrock/terraform.tfstate"
    region = "us-east-1"
  }
}