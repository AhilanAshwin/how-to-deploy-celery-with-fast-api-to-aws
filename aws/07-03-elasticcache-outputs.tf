# output "elasticache_endpoint" {
#   description = "Configuration endpoint to allow host disocvery"
#   value       = aws_elasticache_cluster.redis.configuration_endpoint
# }

# output "elasticache_cache_nodes" {
#   description = "List of node objects"
#   value       = aws_elasticache_cluster.redis.cache_nodes
# }

output "redis_cluster_mode" {
  description = "Identify if in cluster mode"
  value       = aws_elasticache_replication_group.redis.cluster_enabled
}

output "redis_primary_endpoint_address" {
  description = "Address of the endpoint for the primary node in the replication group"
  value       = aws_elasticache_replication_group.redis.primary_endpoint_address
}
