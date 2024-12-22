### data route53 ###

data "aws_route53_zone" "saharbittman" {
  name         = "saharbittman.com"
  private_zone = false
}

### main ssl + dns ###


resource "aws_route53_record" "www_cname" {
  zone_id = data.aws_route53_zone.saharbittman.zone_id
  name    = "www.${data.aws_route53_zone.saharbittman.name}"
  type    = "CNAME"
  ttl     = 300
  records = [var.cname] 
}

# # request public certificates from the amazon certificate manager.
# resource "aws_acm_certificate" "acm_certificate" {
#   domain_name               = data.aws_route53_zone.saharbittman.name
#   #subject_alternative_names = [data.aws_route53_zone.route53_zone.domain_name]
#   validation_method         = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }


# # create a record set in route 53 for domain validatation
# resource "aws_route53_record" "route53_record" {
#   for_each = {
#     for dvo in aws_acm_certificate.acm_certificate.domain_validation_options : dvo.domain_name => {
#       name   = dvo.resource_record_name
#       record = dvo.resource_record_value
#       type   = dvo.resource_record_type
#     }
#   }

#   allow_overwrite = true
#   name            = each.value.name
#   records         = [each.value.record]
#   ttl             = 60
#   type            = each.value.type
#   zone_id         = data.aws_route53_zone.saharbittman.zone_id
# }

# # validate acm certificates
# resource "aws_acm_certificate_validation" "acm_certificate_validation" {
#   certificate_arn         = aws_acm_certificate.acm_certificate.arn
#   validation_record_fqdns = [for record in aws_route53_record.route53_record : record.fqdn]
# }