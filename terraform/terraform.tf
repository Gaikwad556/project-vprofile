provider "aws" {
  region = var.REGION
}

terraform {
  backend "s3" {
    bucket = "project-vprofile-556"
    key    = "file/terraform.tfstate"
    region = "us-west-1"
  }
}
