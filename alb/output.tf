### output alb ##

output "alb_dns" {
  value = aws_lb.web.dns_name
}

output "target_group_arn" {
  description = "The arn of target group"
  value = aws_lb_target_group.web.arn
}

output "sg_id" {
  value = aws_security_group.alb.id
}

output "alb_dns_name" {
  value = aws_lb.web.dns_name
}