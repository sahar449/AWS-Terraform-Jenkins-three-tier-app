### variables root ###

variable "region" {
  default = ""
}


variable "vpc" {
  description = "VPC configuration"
  type = object({
    cidr_block = string
    tags       = map(string)
  })
}

variable "subnets" {
  description = "Subnets configuration"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    map_public_ip     = bool
    tags              = map(string)
  }))
}

variable "internet_gateway" {
  description = "Internet Gateway configuration"
  type = object({
    tags = map(string)
  })
}

variable "route_table" {
  description = "Route table configuration"
  type = object({
    routes = list(object({
      cidr_block = string
      gateway_id = string
    }))
    tags = map(string)
  })
}

