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
  subnet1_id = module.vpc.subnet1_id.id
  subnet2_id = module.vpc.subnet2_id.id
}

module "alb" {
  source            = "./alb"
  vpc_id = module.vpc.vpc_id
  subnet1_id = module.vpc.subnet1_id.id
  subnet2_id = module.vpc.subnet2_id.id
  web_instance = module.ec2.id
}
