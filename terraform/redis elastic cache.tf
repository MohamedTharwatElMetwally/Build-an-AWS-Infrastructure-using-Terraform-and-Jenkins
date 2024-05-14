

# resource "aws_elasticache_subnet_group" "redis_subnet_group" {
#   name       = "redis-subnet-group"
#   subnet_ids = [module.network-module.subnets["my_private_subnet"].id]

#   tags = {
#     Name = "My Redis Subnet Group"
#   }
# }

# resource "aws_elasticache_cluster" "redis_cluster" {
#   cluster_id        = "redis-cluster"
#   engine            = "redis"
#   engine_version    = "5.0.6"
#   node_type         = "cache.t3.micro"
#   num_cache_nodes   = 1
#   subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group.name
# }
