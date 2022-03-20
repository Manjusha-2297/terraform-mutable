resource "aws_lb_target_group" "test" {
  name     = "${var.component}-${var.env}-tg"
  port     = var.port
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.VPC_ID
}
