
output vpc_id {
    value = aws_vpc.my-vpc.id
    description = "vpc id"
}

output subnets {
    value = aws_subnet.subnets
    description = "subnets"
}
