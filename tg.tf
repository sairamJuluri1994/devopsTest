resource "aws_lb_target_group" "crudtg" {
  name              = "crudtg"
  port              = 80
  protocol          = "HTTP"
  vpc_id            = var.vpc_id
  target_type       = "instance"
  proxy_protocol_v2 = "false"
  health_check {
    enabled  = "true"
    port     = 80
    path     = "/"
    matcher  = 200
    interval = 60
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "crudtg-attachment" {
  count            = 3
  target_group_arn = aws_lb_target_group.crudtg.arn
  target_id        = aws_instance.crud[count.index].id
  port             = 80
}
