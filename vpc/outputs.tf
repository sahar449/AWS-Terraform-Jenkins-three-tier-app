### output vpc ###

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet1_id" {
  value = aws_subnet.subnet_1.id
}

output "subnet2_id" {
  value = aws_subnet.subnet_2.id
}
