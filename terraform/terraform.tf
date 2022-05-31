terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16.0"
    }
  }

  backend "s3" {
    bucket = "fastapi-ecs-fargate"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }

  required_version = ">= 1.2.1"
}
