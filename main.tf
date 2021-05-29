terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.61.0"
    }
  }
}
provider "aws" {
    #alias = "Amazon"
    region = "ap-south-1"
}
provider "aws" {
    alias = "Amazon"
    region = "eu-west-1"
}
provider "azurerm" {
    alias = "Azure"
  # Configuration options
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "PoC-1" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  #instance_state = "running"
  tags = {
    "Name" = "TF-PoC-1"
  
  }
}

output "Instance_Name" {
   value = aws_instance.PoC-1.tags.Name  
}

output "PublicIP" {
  value = aws_instance.PoC-1.public_ip
  
}

output "Instance_AZ" {
  value = aws_instance.PoC-1.availability_zone
  
}

output "Instance_Type" {
  value = aws_instance.PoC-1.instance_type
}
output "Instance_State" {
  value = aws_instance.PoC-1.instance_state
}

output "Instance_ID" {
  value = aws_instance.PoC-1.id
}
