data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

resource "aws_ecr_repository" "fastapi-ecs-fargate-registry" {
  name                 = "${var.aws_resource_prefix}-registry"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

module "base-network" {
  source                                      = "cn-terraform/networking/aws"
  version                                     = "2.0.7"
  name_preffix                                = "${var.aws_resource_prefix}-networking"
  vpc_cidr_block                              = "192.168.0.0/16"
  availability_zones                          = ["us-east-1a", "us-east-1b"]
  public_subnets_cidrs_per_availability_zone  = ["192.168.0.0/19", "192.168.32.0/19"]
  private_subnets_cidrs_per_availability_zone = ["192.168.128.0/19", "192.168.160.0/19"]
}

module "ecs-fargate" {
  source                                         = "cn-terraform/ecs-fargate/aws"
  version                                        = "2.0.41"
  name_prefix                                    = var.aws_resource_prefix
  vpc_id                                         = module.base-network.vpc_id
  container_image                                = "${local.account_id}.dkr.ecr.${var.default_region}.amazon.com/${aws_ecr_repository.fastapi-ecs-fargate-registry.name}"
  container_name                                 = "${var.aws_resource_prefix}-container"
  public_subnets_ids                             = module.base-network.public_subnets_ids
  private_subnets_ids                            = module.base-network.private_subnets_ids
  s3_bucket_server_side_encryption_sse_algorithm = "AES256"
}

