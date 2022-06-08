resource "aws_iam_user" "fastapi-terraform" {
  name = "fastapi-terraform"
}


resource "aws_iam_user_policy" "fastapi-terraform-policy" {
  name        = "terraform_policy"
  user = aws_iam_user.fastapi-terraform.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "ec2:CreateVpc",
          "ec2:AllocateAddress",
          "ec2:ModifyVpcAttribute",
          "ec2:ModifySubnetAttribute",
          "ec2:CreateRouteTable",
          "ec2:CreateInternetGateway",
          "ec2:CreateSubnet",
          "ec2:CreateTags",
          "ec2:CreateSecurityGroup",
          "ec2:AttachInternetGateway",
          "ec2:CreateRoute",
          "ec2:CreateNatGateway",
          "ec2:AssociateRouteTable",
          "ec2:RevokeSecurityGroupEgress",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:AuthorizeSecurityGroupIngress",
          "s3:List*",
          "s3:Get*",
          "s3:Put*",
          "s3:CreateBucket",
          "s3:HeadBucket",
          "s3:DeleteBucket",
          "s3:DeleteObject",
          "dynamodb:Describe*",
          "dynamodb:GetItem",
          "dynamodb:CreateTable",
          "dynamodb:ListTagsOfResource",
          "dynamodb:PutItem",
          "dynamodb:TagResource",
          "dynamodb:DeleteItem",
          "ecs:Describe*",
          "ecs:CreateCluster",
          "ecs:RegisterTaskDefinition",
          "ecs:CreateService",
          "ecr:DescribeRepositories*",
          "ecr:CreateRepository",
          "ecr:ListTagsForResource",
          "acm:DescribeCertificate",
          "acm:RequestCertificate",
          "acm:ListTagsForCertificate",
          "elasticloadbalancing:Describe*",
          "elasticloadbalancing:CreateLoadBalancer",
          "elasticloadbalancing:ModifyLoadBalancerAttributes",
          "elasticloadbalancing:SetSecurityGroups",
          "elasticloadbalancing:SetIpAddressType",
          "elasticloadbalancing:AddTags",
          "elasticloadbalancing:CreateTargetGroup",
          "elasticloadbalancing:CreateListener",
          "elasticloadbalancing:ModifyTargetGroupAttributes",
          "iam:Get*",
          "iam:CreateRole",
          "iam:ListRolePolicies",
          "iam:ListAttachedRolePolicies",
          "iam:AttachRolePolicy",
          "iam:PassRole",
          "iam:PutUserPolicy",
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "application-autoscaling:Describe*",
          "application-autoscaling:RegisterScalableTarget",
          "application-autoscaling:PutScalingPolicy",
          "application-autoscaling:DeleteScalingPolicy",
          "cloudwatch:PutMetricAlarm",
          "cloudwatch:DescribeAlarms",
          "cloudwatch:ListTagsForResource",
          "cloudwatch:DeleteAlarms"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
