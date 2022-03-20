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

resource "aws_lb_target_group_attachment" "instance-attach" {
  count = length(local.all_instance_id)
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = element(local.all_instance_id, count.index)
  port             = var.port
}