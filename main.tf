### root main ###

provider "aws" {
  region = "us-west-2"  # Adjust to your desired region
}

module "vpc" {
  source             = "./vpc"
}

module "ec2" {
  source          = "./ec2"
  vpc_id = module.vpc.vpc_id
  subnet1_id = module.vpc.subnet1_id
  subnet2_id = module.vpc.subnet2_id
}

module "alb" {
  source            = "./alb"
  vpc_id = module.vpc.vpc_id
  subnet1_id = module.vpc.subnet1_id
  subnet2_id = module.vpc.subnet2_id
  ec2_id1 = module.ec2.ec2_id1
  ec2_id2 = module.ec2.ec2_id2
  sg      = module.ec2.sg
}


output "alb_dns" {
  value = module.alb.alb_dns
}