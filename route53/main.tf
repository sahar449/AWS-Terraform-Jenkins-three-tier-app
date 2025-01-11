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
