
variable "vpc_cidr" {
  type        = string
  description = "CIDR Block"
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "region" {
  type        = string
  description = "region"
}

variable "ami" {
  type        = string
  description = "AMI"
}

variable "subnets_details" {
  type = list(object({
    name = string,
    cidr = string,
    availability_zone = string,
    type = string
  }))

  description = "subnets"
}


variable "db_username" {
  type        = string
  description = "Database username"
}

variable "db_password" {
  type        = string
  description = "Database password"
}

variable "my_email" {
  type        = string
  description = "Your Email"
}

variable "statefile_bucket" {
  type        = string
  description = "Backend s3 bucket name"
}

variable "statefile_bucket_arn" {
  type        = string
  description = "Backend s3 bucket arn"
}



