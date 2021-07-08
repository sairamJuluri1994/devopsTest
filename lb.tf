data "aws_subnet_ids" "subnet_ids" {
  vpc_id = var.vpc_id
}

resource "aws_lb" "crud-lb" {
  name               = "crud-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.crudsg.id]
  subnets            = data.aws_subnet_ids.subnet_ids.ids

  enable_deletion_protection = true

  tags = {
    Application = "CRUD AppServer"
  }
}

