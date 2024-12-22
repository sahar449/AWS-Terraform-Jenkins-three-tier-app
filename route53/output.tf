### outputs route53 ###

output "cname" {
  value = aws_route53_record.www_cname.fqdn
}

output "zone_id" {
  value = aws_route53_record.www_cname.zone_id
}

# output "ssl_arn" {
#   value = aws_acm_certificate.acm_certificate.arn
# }