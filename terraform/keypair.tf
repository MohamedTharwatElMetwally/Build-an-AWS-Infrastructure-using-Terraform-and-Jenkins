
# ======= key pair generation

# => option 1: generate the key on your local machine:   $ ssh-keygen -t rsa -b 4096
# resource "aws_key_pair" "deployer-key" {
#   key_name   = "deployer-key"
#   public_key = file("~/.ssh/id_rsa.pub")
# }

# => option 2
resource "tls_private_key" "rsa_generator" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer-key" {
  key_name   = "deployer-key"
  public_key = tls_private_key.rsa_generator.public_key_openssh
}

resource "local_file" "private_key" {
  filename = "private_key.pem"
  content  = tls_private_key.rsa_generator.private_key_pem
}

output "private_key" {
  value = local_file.private_key.filename
}


