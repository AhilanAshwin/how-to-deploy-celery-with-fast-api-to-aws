data "aws_availability_zones" "available" {
  state = "available"
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"
  # insert the 23 required variables here
  name            = "${local.prefix}-vpc"
  cidr            = var.vpc_cidr_block
  azs             = data.aws_availability_zones.available.names
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets

  # Database Subnets
  #   database_subnets                   = var.vpc_database_subnets
  #   create_database_subnet_group       = var.vpc_create_database_subnet_group
  #   create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  # create_database_internet_gateway_route = true
  # create_database_nat_gateway_route = true

  # Elastic Cache Subnets
  elasticache_subnet_group_name         = "${local.prefix}-elasticache"
  elasticache_subnets                   = var.vpc_elastic_cache_subnets
  create_elasticache_subnet_group       = var.vpc_create_elastic_cache_subnet_group
  create_elasticache_subnet_route_table = var.vpc_create_elastic_cache_subnet_route_table

  # NAT Gateways - Outbound Communication
  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = local.common_tags
  vpc_tags = {
    vpc_name = "ECS VPC"
  }

  # Additional Tags to Subnets
  public_subnet_tags = {
    Type = "Public Subnets"
  }
  private_subnet_tags = {
    Type = "Private Subnets"
  }
  elasticache_subnet_tags = {
    "Type" = "Elastic Cache Subnets"
  }
}
