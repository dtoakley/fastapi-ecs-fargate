variable "default_region" {
  type    = string
  default = "us-east-1"
}

variable "AWS_RESOURCE_NAME_PREFIX" {
  type    = string
  default = "fastapi-ecs-fargate"
}

variable "availability_zones" {
  description = "a comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "192.168.0.0/16"
}

variable "private_subnets" {
  description = "a list of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  type        = list(string)
  default     = ["192.168.128.0/19", "192.168.160.0/19"]
}

variable "public_subnets" {
  description = "a list of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  type        = list(string)
  default     = ["192.168.0.0/19", "192.168.32.0/19"]
}

variable "service_desired_count" {
  description = "Number of tasks running in parallel"
  type        = number
  default     = 2
}

variable "container_cpu" {
  description = "The number of cpu units used by the task"
  type        = number
  default     = 256 # If unset, default is 1024 (1 vCPU)
}

variable "container_memory" {
  description = "The amount of memory (in MiB) the container is allows to use"
  type        = number
  default     = 512 # If unset, default is 4096 (4 GB)
}

variable "container_memory_reservation" {
  description = "The amount of memory (in MiB) reserved for the container"
  type        = number
  default     = 256 # If unset, default is 2048 (2 GB)
}

variable "port_mappings" {
  description = "The port mappings to configure for the container"
  type = list(object({
    containerPort = number
    hostPort      = number
    protocol      = string
  }))
  default = [
    {
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    },
    {
      containerPort = 443
      hostPort      = 443
      protocol      = "tcp"
    }
  ]
}

variable "lb_http_ports" {
  description = "Map containing objects to define listeners behaviour based on type field. If type field is `forward`, include listener_port and the target_group_port. For `redirect` type, include listener port, host, path, port, protocol, query and status_code. For `fixed-response`, include listener_port, content_type, message_body and status_code"
  type        = map(any)

  default = {
    default_http = {
      type          = "redirect"
      listener_port = 80
      port          = 443
      protocol      = "HTTPS"
      status_code   = "HTTP_301"
    }
  }
}

#variable "lb_https_ports" {
#  description = "Map containing objects with two fields, listener_port and the target_group_port to redirect HTTPS requests"
#  type        = map(any)
#  default = {
#    default_http = {
#      listener_port     = 443
#      target_group_port = 80
#    }
#  }
#}
