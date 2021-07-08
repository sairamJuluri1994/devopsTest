resource "aws_instance" "crud" {
  ami             = "ami-09246ddb00c7c4fef"
  count           = 3
  key_name        = "sairam"
  instance_type   = "t2.micro"
  security_groups = ["crudsg"]
  user_data       = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo amazon-linux-extras install nginx1 -y
  sudo systemctl start nginx
  EOF
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "CRUD AppServer ${count.index}"
  }
}
