### vars vpc ###

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_1_cidr" {
  description = "CIDR block for the first subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_2_cidr" {
  description = "CIDR block for the second subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone_1" {
  description = "Availability zone for the first subnet"
  type        = string
  default     = "us-west-2a"
}

variable "availability_zone_2" {
  description = "Availability zone for the second subnet"
  type        = string
  default     = "us-west-2b"
}

variable "route_table_name" {
  description = "Name tag for the route table"
  type        = string
  default     = "my_route_table"
}

variable "internet_gateway_name" {
  description = "Name tag for the Internet Gateway"
  type        = string
  default     = "my_internet_gateway"
}

variable "subnet_1_name" {
  description = "Name tag for the first subnet"
  type        = string
  default     = "my_subnet_1"
}

variable "subnet_2_name" {
  description = "Name tag for the second subnet"
  type        = string
  default     = "my_subnet_2"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "my_vpc"
}
