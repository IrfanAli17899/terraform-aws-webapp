terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

module "web_server" {
  source        = "./modules/web_server"
  instance_type = var.instance_type
  ami           = var.ami
  key_name      = var.key_name
  vpc_id = aws_vpc.main.id
}
