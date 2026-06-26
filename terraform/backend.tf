terraform {
  backend "s3" {
    bucket = "project-bedrock-tfstate-093831816623"
    key    = "project-bedrock/terraform.tfstate"
    region = "us-east-1"
  }
}