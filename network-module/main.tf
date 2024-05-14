
# VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}


# Subnets
resource "aws_subnet" "subnets" {
  for_each          = { for subnet in var.subnets_details : subnet.name => subnet }
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.availability_zone
  tags = {
    Name = "${var.vpc_name}_${each.value.name}_subnet"
    Type = "${each.value.type}"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "IGW"
  }
}



# ======= Creating Route table for Public Subnets
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.my-vpc.id

  # route {   # can be created as a separate resource.
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_internet_gateway.IGW.id
  # }

  tags = {
    Name = "rt_public"
  }
}

resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.rt_public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.IGW.id
}

# Associate all public subnets to the rt_public route table
resource "aws_route_table_association" "rt_associate_public" {
  for_each = { for idx, subnet in aws_subnet.subnets : idx => subnet if subnet.tags["Type"] == "public" }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt_public.id
}



# ======= Creating Route table for Private Subnets
resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "rt_private"
  }
}

# Associate all private subnets to the rt_private route table
resource "aws_route_table_association" "rt_associate_private" {
  for_each = { for idx, subnet in aws_subnet.subnets : idx => subnet if subnet.tags["Type"] == "private" }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt_private.id
}
