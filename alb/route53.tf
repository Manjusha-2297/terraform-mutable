resource "aws_route53_record" "public-alb" {
  count = var.env == "prod" ? 1 :0
  zone_id = data.terraform_remote_state.vpc.outputs.public_hosted_zone_id
  name    = "roboshop.manjusha.online"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.public.dns_name]
}
