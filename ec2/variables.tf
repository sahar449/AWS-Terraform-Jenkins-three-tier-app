### variables ec2 ###

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "subnet1_id" {
  description = "subnet1 id"
  type        = string
}

variable "subnet2_id" {
  description = "subnet2 id"
  type        = string
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}