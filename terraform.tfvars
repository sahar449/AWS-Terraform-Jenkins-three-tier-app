# terraform.tfvars (Root Module)

region = "us-west-2"

# VPC Configuration
vpc = {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my_vpc"
  }
}

# Subnets Configuration
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

# Internet Gateway Configuration
internet_gateway = {
  tags = {
    Name = "my_internet_gateway"
  }
}

# Route Table Configuration
route_table = {
  routes = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = ""  # Leave empty to be dynamically assigned by Terraform
    }
  ]
  tags = {
    Name = "my_route_table"
  }
}
