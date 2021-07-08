resource "aws_lb_listener" "crud-listener" {
  load_balancer_arn = aws_lb.crud-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.crudtg.arn
  }
}

resource "aws_alb_listener_rule" "alb_rules" {
  listener_arn = aws_lb_listener.crud-listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.crudtg.arn
  }
  condition {
    path_pattern {
      values = ["/"]
    }
  }
  depends_on = [
    aws_lb.crud-lb,
  ]
}
