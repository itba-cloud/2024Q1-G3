variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "subnet_1_cidr" {
  description = "The CIDR block for the first private subnet"
}

variable "subnet_2_cidr" {
  description = "The CIDR block for the second private subnet"
}

variable "availability_zone_1" {
  description = "The availability zone for the first private subnet"
}

variable "availability_zone_2" {
  description = "The availability zone for the second private subnet"
}

variable "subnet_1_name" {
  description = "The name of the first private subnet"
  default     = "PrivateSubnet1"
}

variable "subnet_2_name" {
  description = "The name of the second private subnet"
  default     = "PrivateSubnet2"
}
