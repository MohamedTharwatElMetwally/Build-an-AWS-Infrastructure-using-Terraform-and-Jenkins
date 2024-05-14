
# ======= Creating EC2 instance on public subnet
resource "aws_instance" "public-instance-bastian" {
  ami           = var.ami
  instance_type = "t2.micro"

  subnet_id                   = module.network-module.subnets["my_public_subnet"].id
  associate_public_ip_address = true

  tags = {
    Name = "public-instance-bastian"
  }

  vpc_security_group_ids = [aws_security_group.sg_public.id]

  key_name = aws_key_pair.deployer-key.key_name # it will include the public key, so you don't need to add it in the user data

  provisioner "local-exec" {
    command = "echo \"The public server's public IP address is ${self.public_ip}\" && echo \"The public server's private IP address is ${self.private_ip}\""
  }


  user_data = <<-EOF
              #!/bin/bash
              echo "${local_file.private_key.content}" > /home/ec2-user/.ssh/id_rsa
              echo "${local_file.private_key.content}" > ~/.ssh/id_rsa
              chmod 600 /home/ec2-user/.ssh/id_rsa
              chmod 600 ~/.ssh/id_rsa
              sudo chown ec2-user:ec2-user ~/.ssh/id_rsa
EOF

}


# ======= Creating EC2 instance on private subnet
resource "aws_instance" "private-instance" {
  ami           = var.ami
  instance_type = "t2.micro"

  subnet_id                   = module.network-module.subnets["my_private_subnet"].id
  associate_public_ip_address = false

  tags = {
    Name = "private-instance"
  }

  vpc_security_group_ids = [aws_security_group.sg_private.id]

  key_name = aws_key_pair.deployer-key.key_name # it will include the public key, so you don't need to add it in the user data

  provisioner "local-exec" {
    command = "echo \"The private server's private IP address is ${self.private_ip}\""
  }
}

