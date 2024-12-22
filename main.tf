### root main ###

provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-west-2" 
}

#Terraform Block
terraform {
  required_version = "~> 1.5.0" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "sahar-tff" #replace with you bucket
    key    = "terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform-lock"
    
  }
}

resource "null_resource" "dynamodb_create_table" {
  provisioner "local-exec" {
    command = <<EOT
aws dynamodb create-table \
    --table-name terraform-lock \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --tags "Environment=Production,Purpose=TerraformStateLocking" \
    --region us-west-2
EOT
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}


module "vpc" {
  source          = "./vpc"
}

module "ec2" {
  source         = "./ec2"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = {
    subnet_1 = module.vpc.subnet1_id
    subnet_2 = module.vpc.subnet2_id
  }
  sg_alb = module.alb.sg_id
}

module "alb" {
  source            = "./alb"
  vpc_id = module.vpc.vpc_id
  subnet1_id = module.vpc.subnet1_id
  subnet2_id = module.vpc.subnet2_id
  ec2_id1 = module.ec2.ec2_id1
  ec2_id2 = module.ec2.ec2_id2
}

module "route53" {
  source = "./route53"
  cname = module.alb.alb_dns
}

module "asg" {
  source = "./asg"
  subnet1_id = module.vpc.subnet1_id
  subnet2_id = module.vpc.subnet2_id
  vpc_id = module.vpc.vpc_id
  sg_id     = module.ec2.sg
  lb_target_group_arn = module.alb.target_group_arn
}


#Display the HTML content that I configured in the EC2 user data on the screen.
resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "sleep 30 && curl ${module.route53.cname} && curl ${module.route53.cname}"
  }
}
