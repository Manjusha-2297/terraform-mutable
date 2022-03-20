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