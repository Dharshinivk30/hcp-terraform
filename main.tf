terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Provider Blockk
provider "aws" {
  region  = "ap-south-1"
}

resource "aws_instance" "my-ec2-vm" {
  ami           = var.ec2-ami
  instance_type = var.ec2-type
  count = 4
  tags = {
    "Name" = "HCP-EC2-${count.index}"
  }
}

variable "ec2-ami" {
  description = "AWS EC2 AMI"
  type = string
}

variable "ec2-type" {
  description = "AWS EC2 type"
  type = string
}

output "pub_ip" {
  description = "My machine public ip"
  value       = aws_instance.my-ec2-vm[*].public_ip
}
