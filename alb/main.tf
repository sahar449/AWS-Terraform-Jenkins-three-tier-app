### main alb ###

resource "aws_security_group" "ec2_alb" {
  name        = "allow_http_ec2 and alb"
  vpc_id      = var.vpc_id
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

resource "aws_lb" "web" {
  name               = "web-lb-new"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2_alb.id]
  subnets            = [aws_subnet.subnet1_id.id, aws_subnet.subnet2_id.id]

  tags = {
    Name = "web-lb-new"
  }
}

resource "aws_lb_target_group" "web" {
  name     = "web-tg-new"
  port     = 80
  protocol = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
  }
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

resource "aws_lb_target_group_attachment" "web1" {
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = aws_instance.web1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web2" {
  count            = 2
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = aws_instance.web2.id
  port             = 80
}