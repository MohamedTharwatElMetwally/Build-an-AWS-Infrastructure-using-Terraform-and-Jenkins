
# ======= Creating Security Group for Public Subnet
resource "aws_security_group" "sg_public" {
  name        = "sg_public"
  description = "security group for public EC2 instance (Bastian)"

  vpc_id = module.network-module.vpc_id

  # Define ingress rules (inbound traffic)
  ingress {
    description = "SSH"
    from_port   = 22 # Source port (for outgoing traffic)
    to_port     = 22 # Destination port (for incoming traffic)
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from any source
  }

  # Define engress rules (outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all traffic to leave
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# ======= Creating Security Group for Private Subnet
resource "aws_security_group" "sg_private" {
  name        = "sg_private"
  description = "security group for private EC2 instance"

  vpc_id = module.network-module.vpc_id

  # Define ingress rules (inbound traffic)

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # Define engress rules (outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all traffic to leave
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# note that: in SSH, you must define egress, although the security group is satefull.






# resource "aws_security_group" "test_sg" {
#   name        = "test_sg"
#   description = "security group for test"

#   vpc_id = module.network-module.vpc_id

#   # Define ingress rules (inbound traffic)
#   ingress {
#     description = "SSH"
#     from_port   = 22 # Source port (for outgoing traffic)
#     to_port     = 22 # Destination port (for incoming traffic)
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # Allow traffic from any source
#   }

#   # Define engress rules (outbound traffic)
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1" # Allow all traffic to leave
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }