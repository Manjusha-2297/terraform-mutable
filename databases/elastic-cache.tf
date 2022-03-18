resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-${var.env}"
  engine               = "redis"
  node_type            = var.elasticcache_instance_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  engine_version       = "6.x"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.subnet-group.name
  security_group_ids = [aws_security_group.allow_redis.id]
}

resource "aws_elasticache_subnet_group" "subnet-group" {
  name       = "redis-${var.env}"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS
}

resource "aws_security_group" "allow_redis" {
  name        = "allow_redis_${var.env}"
  description = "Allow redis"
  vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress = [
    {
      description      = "redis"
      from_port        = 6379
      to_port          = 6379
      protocol         = "tcp"
      cidr_blocks      = data.terraform_remote_state.vpc.outputs.VPC_CIDR
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
      security_groups  = []
    }

  ]
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }

  tags = {
    Name = "allow_redis_${var.env}"
  }
}

output "elastic" {
  value = aws_elasticache_cluster.redis.cache_nodes[0].address
}
