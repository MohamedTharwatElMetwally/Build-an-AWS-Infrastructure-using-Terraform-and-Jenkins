

# resource "aws_security_group" "rds_sg" {
#   name        = "rds_sg"
#   description = "security group for RDS instance"

#   vpc_id = module.network-module.vpc_id

#   # Define ingress rules (inbound traffic)
#   ingress {
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = [var.vpc_cidr]
#   }

#   # Define engress rules (outbound traffic)
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1" # Allow all traffic to leave
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# resource "aws_db_subnet_group" "my_db_subnet_group" {
#   name       = "my-db-subnet-group"
#   subnet_ids = [module.network-module.subnets["my_private_subnet"].id, module.network-module.subnets["my_private_subnet_2"].id]  # at least two subnets in two different AZs.

#   tags = {
#     Name = "My DB Subnet Group"
#   }
# }

# resource "aws_db_instance" "my_database" {
#   allocated_storage      = 5
#   storage_type           = "gp2"
#   engine                 = "mysql"
#   engine_version         = "5.7"
#   instance_class         = "db.t3.micro"
#   identifier             = "mydb"
#   username               = var.db_username
#   password               = var.db_password
#   vpc_security_group_ids = [aws_security_group.rds_sg.id]
#   db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name

#   skip_final_snapshot = true
# }
