resource "aws_ecr_repository" "fastapi-ecs-fargate" {
  name                 = "${var.aws_resource_prefix}-registry"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

#module "ecs-fargate" {
#  source  = "cn-terraform/ecs-fargate/aws"
#  version = "2.0.41"
#  container_image = "fastapi-"
#  command = ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
#}

