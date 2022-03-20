resource "aws_lb_target_group" "target-group" {
  name     = "${var.component}-${var.env}-tg"
  port     = var.port
  protocol = "HTTP"
  vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID
  health_check {
    enabled = true
    healthy_threshold = 2
    interval = 5
    path = "/health"
    port = var.port
    unhealthy_threshold = 2
    timeout = 4
  }
}
