data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

resource "aws_ecr_repository" "fastapi-ecs-fargate-registry" {
  name                 = "${var.AWS_RESOURCE_NAME_PREFIX}-registry"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_acm_certificate" "fastapi-ecs-fargate-ssl-cert" {
  domain_name       = "local"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

module "base-network" {
  source                                      = "cn-terraform/networking/aws"
  version                                     = "2.0.7"
  name_preffix                                = "${var.AWS_RESOURCE_NAME_PREFIX}-networking"
  vpc_cidr_block                              = var.cidr
  availability_zones                          = var.availability_zones
  public_subnets_cidrs_per_availability_zone  = var.public_subnets
  private_subnets_cidrs_per_availability_zone = var.private_subnets
}

module "ecs-fargate" {
  source                                         = "cn-terraform/ecs-fargate/aws"
  version                                        = "2.0.41"
  name_prefix                                    = var.AWS_RESOURCE_NAME_PREFIX
  vpc_id                                         = module.base-network.vpc_id
  container_image                                = "${local.account_id}.dkr.ecr.${var.default_region}.amazonaws.com/${aws_ecr_repository.fastapi-ecs-fargate-registry.name}"
  container_name                                 = "${var.AWS_RESOURCE_NAME_PREFIX}-container"
  public_subnets_ids                             = module.base-network.public_subnets_ids
  private_subnets_ids                            = module.base-network.private_subnets_ids
  s3_bucket_server_side_encryption_sse_algorithm = "AES256"
  container_cpu                                  = var.container_cpu
  container_memory                               = var.container_memory
  container_memory_reservation                   = var.container_memory_reservation
  desired_count                                  = var.service_desired_count
  port_mappings                                  = var.port_mappings
  lb_http_ports                                  = var.lb_http_ports
  default_certificate_arn                        = aws_acm_certificate.fastapi-ecs-fargate-ssl-cert.arn
  ssl_policy                                     = "ELBSecurityPolicy-2016-08"
}

