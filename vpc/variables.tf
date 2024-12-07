variable "network_config" {
  description = "Network configuration for VPC, subnets, IGW, and route table"
  type = object({
    vpc = object({
      cidr_block = string
      tags       = map(string)
    })
    subnets = map(object({
      cidr_block        = string
      availability_zone = string
      map_public_ip     = bool
      tags              = map(string)
    }))
    internet_gateway = object({
      tags = map(string)
    })
    route_table = object({
      routes = list(object({
        cidr_block = string
        gateway_id = string
      }))
      tags = map(string)
    })
  })
  default = {
    vpc = {
      cidr_block = "10.0.0.0/16"
      tags = {
        Name = "my_vpc"
      }
    }
    subnets = {
      subnet_1 = {
        cidr_block        = "10.0.1.0/24"
        availability_zone = "us-west-2a"
        map_public_ip     = true
        tags = {
          Name = "my_subnet_1"
        }
      }
      subnet_2 = {
        cidr_block        = "10.0.2.0/24"
        availability_zone = "us-west-2b"
        map_public_ip     = true
        tags = {
          Name = "my_subnet_2"
        }
      }
    }
    internet_gateway = {
      tags = {
        Name = "my_internet_gateway"
      }
    }
    route_table = {
      routes = [
        {
          cidr_block = "0.0.0.0/0"
          gateway_id = "" # To be dynamically set
        }
      ]
      tags = {
        Name = "my_route_table"
      }
    }
  }
}
