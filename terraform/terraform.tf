terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16.0"
    }
  }

  backend "s3" {
    encrypt        = true
    bucket         = "fastapi-ecs-fargate"
    dynamodb_table = "terraform-state-lock-dynamodb"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }

  required_version = ">= 1.0.0"
}
