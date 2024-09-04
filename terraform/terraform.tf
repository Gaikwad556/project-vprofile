provider "aws" {
  region = var.REGION
}

data "aws_secretsmanager_secret_version" "my_private_key_ansible" {
  secret_id = "MyAnsiblePrivateKey_"
}

data "aws_secretsmanager_secret_version" "my_private_key_docker" {
  secret_id = "MyDockerPrivateKey_"
}

data "aws_secretsmanager_secret_version" "my_private_key_kubernetes" {
  secret_id = "MyKubernetesPrivateKey_"
}

data "aws_secretsmanager_secret_version" "my_private_key_jenkins" {
  secret_id = "MyJenkinsPrivateKey_"
}

data "aws_secretsmanager_secret_version" "my_private_key_sonarqube" {
  secret_id = "MySonarqubePrivateKey_"
}

terraform {
  backend "s3" {
    bucket = "project-vprofile-556"
    key    = "file/terraform.tfstate"
    region = "us-west-1"
  }
}
