### variables ec2 ###

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "sg_alb" {
  type = string
}

variable "ec2_instances" {
  description = "Map of EC2 instance configurations"
  type = map(object({
    instance_type = string
    subnet_key    = string  # Reference to the subnet key for each instance
    tags          = map(string)
  }))
  default = {
    web1 = {
      instance_type = "t2.micro"
      subnet_key    = "subnet_1"  # Reference subnet_1 from subnet_ids
      tags = {
        Name = "web-server-1"
      }
    },
    web2 = {
      instance_type = "t2.micro"
      subnet_key    = "subnet_2"  # Reference subnet_2 from subnet_ids
      tags = {
        Name = "web-server-2"
      }
    }
  }
}

variable "subnet_ids" {
  description = "Map of subnet IDs for EC2 instances"
  type = map(string)
  default = {
    subnet_1 = ""
    subnet_2 = ""
  }
}