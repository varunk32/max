terraform {
  backend "s3" {}
}

provider "aws" {
  region = "ap-southeast-2"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.19.0"

  instance_count = var.instance_count

  name          = var.instance_name
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.instance_key_name
  subnet_id     = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids      = [data.aws_security_group.default.id]
  associate_public_ip_address = var.associate_public_ip_address

  root_block_device = var.root_block_device

  tags = var.instance_tags
}
