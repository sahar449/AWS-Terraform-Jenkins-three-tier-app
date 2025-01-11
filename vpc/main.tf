# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc.cidr_block
  tags       = var.vpc.tags
}

# Create Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags   = var.internet_gateway.tags
}

# Create Subnets
resource "aws_subnet" "subnets" {
  for_each = var.subnets

  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip
  tags                    = each.value.tags
}

# Create a Route Table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  dynamic "route" {
    for_each = var.route_table.routes
    content {
      cidr_block = route.value.cidr_block
      gateway_id = aws_internet_gateway.my_igw.id
    }
  }

  tags = var.route_table.tags
}

# Associate the Route Table with Subnets
resource "aws_route_table_association" "subnet_associations" {
  for_each      = aws_subnet.subnets
  subnet_id     = each.value.id
  route_table_id = aws_route_table.my_route_table.id
}