
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

variable "subnets_details" {
  type = list(object({
    name = string,
    cidr = string,
    availability_zone = string,
    type = string
  }))

  description = "subnets"
}

