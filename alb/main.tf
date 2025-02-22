### main alb ###

resource "aws_security_group" "alb" {
  name        = "sg_nginx_neww"
  vpc_id      = var.vpc_id

  ingress {
    description = "Expose port 80 only for ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Reference to the ALB security group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http_from_alb"
  }
}

resource "aws_lb" "web" {
  name               = "web-lb-new"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [var.subnet1_id, var.subnet2_id]

  tags = {
    Name = "web-lb-new"
  }
}

resource "aws_lb_target_group" "web" {
  name     = "nginxTG"
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
  target_id        = var.ec2_id1
  port             = 80
}

resource "aws_lb_target_group_attachment" "web2" {
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = var.ec2_id2
  port             = 80
}