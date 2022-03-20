resource "aws_route53_record" "app-lb" {
  count   = var.is_public == "false" ? 1 : 0
  zone_id = data.terraform_remote_state.vpc.outputs.private_hosted_zone_id
  name    = "${var.component}-${var.env}.roboshop.internal"
  type    = "CNAME"
  ttl     = "300"
  records = [data.terraform_remote_state.alb.outputs.INTERNAL_LB_NAME]
}

resource "aws_route53_record" "public-lb" {
  count   = var.is_public == "false" ? 0 : 1
  zone_id = data.terraform_remote_state.vpc.outputs.private_hosted_zone_id
  name    = "${var.component}-${var.env}.roboshop.internal"
  type    = "CNAME"
  ttl     = "300"
  records = [data.terraform_remote_state.alb.outputs.PUBLIC_LB_NAME]
}

