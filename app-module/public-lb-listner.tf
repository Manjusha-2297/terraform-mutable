resource "aws_lb_listener" "public" {
  count        = var.is_public == "false" ? 0 : 1
  load_balancer_arn = data.terraform_remote_state.alb.outputs.PUBLIC_LB_ARN
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "public-https" {
  count        = var.is_public == "false" ? 0 : 1
  load_balancer_arn = data.terraform_remote_state.alb.outputs.PUBLIC_LB_ARN
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:286176496219:certificate/841b69f2-41ab-4850-b7c2-5220680b7b5f"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}