
terraform {
  required_version = ">= 1.10.0"

  backend "s3" {
    bucket       = "terraform-abhay-tfstate-452258152284-20261112"
    key          = "part2/terraform.tfstate"
    region       = "ap-southeast-2"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# Backend security group
resource "aws_security_group" "backend" {
  name        = "Terraform-Part2-Backend-SG"
  description = "Private Flask backend access from frontend EC2"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description     = "Flask access only from frontend security group"
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.frontend.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Terraform-Part2-Backend-SG"
    Project = "Terraform-Abhay"
    Part    = "Part2"
  }
}

# Frontend security group
resource "aws_security_group" "frontend" {
  name        = "Terraform-Part2-Frontend-SG"
  description = "Public Express frontend access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from my public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "Terraform-Part2-Frontend-SG"
    Project = "Terraform-Abhay"
    Part    = "Part2"
  }
}

# Flask backend EC2
resource "aws_instance" "backend" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  subnet_id                   = data.aws_subnets.default.ids[0]
  vpc_security_group_ids      = [aws_security_group.backend.id]
  associate_public_ip_address = true

  user_data                   = file("${path.module}/user_data/backend.sh")
  user_data_replace_on_change = true

  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name    = "Terraform-Abhay-Part2-Backend"
    Project = "Terraform-Abhay"
    Part    = "Part2"
  }
}

# Express frontend EC2
resource "aws_instance" "frontend" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  subnet_id                   = data.aws_subnets.default.ids[0]
  vpc_security_group_ids      = [aws_security_group.frontend.id]
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/user_data/frontend.sh", {
    backend_private_ip = aws_instance.backend.private_ip
  })

  user_data_replace_on_change = true

  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name    = "Terraform-Abhay-Part2-Frontend"
    Project = "Terraform-Abhay"
    Part    = "Part2"
  }
}
