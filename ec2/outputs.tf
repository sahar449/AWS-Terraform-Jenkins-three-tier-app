### output ec2 ###

output "ec2_id1" {
  value = aws_instance.web1.id
}

output "ec2_id2" {
  value = aws_instance.web2.id
}

output "sg" {
  value = aws_security_group.ec2_alb.id
}