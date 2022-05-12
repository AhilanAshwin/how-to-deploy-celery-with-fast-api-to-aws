terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region  = var.aws_region
  profile = "default"
}

# These are a set of local values that can be declared together
locals {
  prefix      = "${var.app_prefix}-${var.environment}"
  image       = var.docker_image
  environment = var.environment
  common_tags = {
    author      = var.author
    environment = var.environment
    division    = var.business_divsion
    app_name    = var.app_name
  }
}
