# ECS cluster will be hosted in a private subnet
module "ecs-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"
  # insert the 3 required variables here
  name        = "${local.prefix}-ecs-sg"
  description = "Security group for ecs cluster. HTTP port open for entire VPC, egress ports are all world open"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR blocks
  ingress_rules       = ["http-80-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags         = local.common_tags
}

# The ALB will be hosted in a public subnet and can reach the ecs cluster via the vpc_cidr_block
module "alb-security-group" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "4.9.0"
  name        = "${local.prefix}-alb-sg"
  description = "Security group for application load balancer. HTTP open for entire Internet (IPv4 CIDR), egress ports are all world open"
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR blocks
  ingress_rules       = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rules & CIDR blocks
  egress_rules = ["all-all"]
  tags         = local.common_tags
}

module "elastic-cache-security-group" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "4.9.0"
  name        = "${local.prefix}-elastic-cache"
  description = "Security group for the elastic-cache cluster."
  vpc_id      = module.vpc.vpc_id
  # Ingress Rules & CIDR blocks
  ingress_rules       = ["redis-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  # Egress Rules & CIDR blocks
  egress_rules = ["all-all"]
  tags         = local.common_tags
}
