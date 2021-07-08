variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "health_check" {
  type = map(any)
  default = {
    interval            = 60
    port                = "80"
    healthy_threshold   = 10
    path                = "/"
    unhealthy_threshold = 10
    timeout             = 10
    protocol            = "HTTP"
    matcher             = 200
  }
}

variable "vpc_id" {
  type    = string
  default = "vpc-207d1a4b"
}

variable "load_balancer" {
  type = map(any)
  default = {
    name = "crud-lb"
    port = "80"
  }
}

