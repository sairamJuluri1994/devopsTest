resource "aws_security_group" "crudsg" {
  description = "security group for crud service"
  name        = "crudsg"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "service_in_lb" {
  description = "Allow Inbound Traffic"

  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.crudsg.id
}
resource "aws_security_group_rule" "service_out" {
  description = "Allow outbound Traffic"

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.crudsg.id
}
