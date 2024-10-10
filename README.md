# Infrastructure as Code with Terraform

## Overview

This repository contains the code and configuration for building, configuring, and orchestrating infrastructure using Terraform. The modules provision resources in AWS, including VPCs, EC2 instances, and security groups. The infrastructure is designed for flexibility and ease of use.

## Terraform Infrastructure

Terraform is used to build the EC2 instances and security groups in AWS, specifically in the `us-west-2` region. Make sure to specify the correct AMI for the region. To insert your public IP into the security groups, modify the `tf_module/main.tf` file at lines (38, 59).

## Folder Structure

- `/tf_module`: Terraform configuration files for infrastructure provisioning.
- `/modules`: Contains various modules for specific components (e.g., VPC, EC2, ALB).
- `main.tf`: The main Terraform configuration that orchestrates the modules.

## Getting Started

### Clone the Repository

To get started, clone the repository:

```bash
git clone https://github.com/sahar449/tf-modulels.git
cd tf-modulels
