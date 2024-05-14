
vpc_cidr = "10.0.0.0/16"
vpc_name = "my-vpc"
region = "us-east-1"
ami = "ami-04e5276ebb8451442"
my_email = "mt2910201@gmail.com"
statefile_bucket     = "terraform-jenkins-task"
subnets_details = [
    {
        name = "my_private_subnet"
        cidr = "10.0.0.0/24"
        type = "private"
        availability_zone = "us-east-1a"
    },
    {
        name = "my_public_subnet"
        cidr = "10.0.1.0/24"
        type = "public"
        availability_zone = "us-east-1a"
    },
    {
        name = "my_private_subnet_2"
        cidr = "10.0.2.0/24"
        type = "private"
        availability_zone = "us-east-1b"
    }
]

