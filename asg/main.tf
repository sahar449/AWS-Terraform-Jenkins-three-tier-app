### main asg ###

resource "aws_launch_template" "example" {
  name_prefix   = "asg-nginx"
  image_id      = "ami-04dd23e62ed049936"  # Replace with your desired AMI
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    # Only one subnet is specified here; the ASG will handle multiple
    subnet_id                   = var.subnet1_id  # Replace with your first subnet ID
    security_groups             = [var.sg_id]    # Replace with your security group ID
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "Sahar Bittman project: Private IP: $(hostname -I)" > /var/www/html/index.html
              EOF
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  min_size          = 1
  max_size          = 3
  desired_capacity  = 2

  vpc_zone_identifier = [
    var.subnet1_id,  # First subnet
    var.subnet2_id   # Second subnet
  ]
}

resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.example.name
  lb_target_group_arn     = var.lb_target_group_arn
}
