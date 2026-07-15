terraform {
  backend "s3" {
    bucket         = "bootstrap"
    key            = "portfolio/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}