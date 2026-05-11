terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.92"
    }
  }
  required_version = ">=1.2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values= ["ubuntu/images/hvm-ssd-gp3/ubuntu-resolute-26.04-amd64-server-*"]
  }

  owners=["099720109477"] # Canonical Id
}

resource "aws_instance" "app_server" {
  ami           = aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags {
    Name = "learn-terraform"
  }
}

