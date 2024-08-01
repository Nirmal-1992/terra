terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "nrmal1234"
}
# Create a security group for the EC2 instance
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = "vpc-02360b03e675a8d96"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "tf1" {
  ami             = "ami-0427090fd1714168b"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.allow_ssh.name]
tags = {
    Name = "MyEC2Instance"
  }
}

