
# AWS Terraform ALB Nginx ASG

## Introduction
This project uses Terraform to provision AWS infrastructure, including a Virtual Private Cloud (VPC), EC2 instances, Application Load Balancer (ALB), and an Auto Scaling Group (ASG) with Nginx web servers. The setup provides a scalable, load-balanced web server environment hosted on AWS.


## Architecture Diagram

![AWS Architecture](./aws-architecture.svg)

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Dependencies](#dependencies)
- [Contributors](#contributors)
- [License](#license)

## Features
- Deploys a fully configurable VPC
- Creates EC2 instances using an Auto Scaling Group
- Configures an Application Load Balancer to distribute traffic
- Automatically installs and configures Nginx on each EC2 instance

## Installation

### Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) installed
- AWS CLI configured with appropriate credentials
- AWS account with permissions for VPC, EC2, and ALB resources

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/sahar449/AWS-tf-alb-Nginx-ASG.git
   ```
2. Navigate into the project directory:
   ```bash
   cd AWS-tf-alb-Nginx-ASG
   ```
3. Initialize the Terraform modules:
   ```bash
   terraform init
   ```
4. Review and modify variables in `variables.tf` as needed.
5. Apply the configuration:
   ```bash
   terraform apply
   ```

## Usage
Once the infrastructure is deployed, the ALB DNS name will be displayed as part of the Terraform output. You can access the Nginx web server by navigating to the ALB's DNS in your browser.

## Configuration
- Modify the `variables.tf` file to adjust VPC settings, instance types, ASG sizes, and more.
- Security groups and networking details can be customized based on your environment.

## Dependencies
- Terraform >= 0.12
- AWS CLI
- Nginx (automatically installed on EC2 instances)

## Contributors
- [sahar449](https://github.com/sahar449)

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
