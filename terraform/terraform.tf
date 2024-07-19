provider "aws" {
  region = var.REGION
}

data "aws_secretsmanager_secret_version" "my_private_key_ansible" {
  secret_id = "MyAnsiblePrivateKey"
}

terraform {
  backend "s3" {
    bucket = "project-vprofile-556"
    key    = "file/terraform.tfstate"
    region = "us-west-1"
  }
}
