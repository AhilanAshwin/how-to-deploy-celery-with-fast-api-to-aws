# resource "aws_elasticache_cluster" "redis" {
#   cluster_id           = "${local.prefix}-redis"
#   engine               = "redis"
#   node_type            = "cache.t3.micro"
#   num_cache_nodes      = 1
#   parameter_group_name = "default.redis6.x"
#   engine_version       = "6.2"
#   port                 = 6379
#   security_group_ids   = [module.elastic-cache-group.security_group_id]
#   subnet_group_name    = module.vpc.elasticache_subnet_group_name
#   tags                 = local.common_tags
# }

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id       = "${local.prefix}-redis"
  description                = "Replication group for the redis cluster"
  node_type                  = "cache.t3.micro"
  num_cache_clusters         = 2
  port                       = 6379
  parameter_group_name       = "default.redis6.x"
  engine_version             = "6.2"
  subnet_group_name          = module.vpc.elasticache_subnet_group_name
  security_group_ids         = [module.elastic-cache-security-group.security_group_id]
  automatic_failover_enabled = true
  tags                       = local.common_tags
}
