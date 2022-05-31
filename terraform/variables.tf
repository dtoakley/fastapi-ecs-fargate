variable "default_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_resource_prefix" {
  type = string
  default = "fastapi-ecs-fargate"
}
