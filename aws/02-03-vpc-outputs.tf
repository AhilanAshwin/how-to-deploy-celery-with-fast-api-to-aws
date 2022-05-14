# VPC Output Values

# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# VPC CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# VPC Private Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

# VPC Public Subnets
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "elasticache_subnets" {
  description = "List of IDs of the elasticache subnets"
  value       = module.vpc.elasticache_subnets
}

output "elasticache_subnet_group_name" {
  description = "Elastic Cache subnet group name"
  value       = module.vpc.elasticache_subnet_group_name
}

# VPC NAT gateway Public IP
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

# VPC AZS
output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = module.vpc.azs
}

