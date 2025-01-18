### main ec2 ###

resource "aws_security_group" "ec2_alb" {
  name        = "sg_nginx_new"
  vpc_id      = var.vpc_id

  ingress {
    description = "Expose port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [var.sg_alb]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  for_each = var.ec2_instances
  user_data = local.user_data_script
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = each.value.instance_type
  subnet_id            = var.subnet_ids[each.value.subnet_key]  # Fetch the subnet ID using subnet_key
  vpc_security_group_ids = [aws_security_group.ec2_alb.id]
  tags                 = each.value.tags
}
