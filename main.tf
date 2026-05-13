terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.92"
    }
  }
  required_version = ">=1.2"
}

provider "aws" { 
  region = "sa-east-1"
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
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "treinamento-ci-cd-api-go"
  user_data     = <<-EOF
                  #!/usr/bin/env bash
                  cd /home/ubuntu
                  cat <<-"EOL" > index.html
                  <head>
                    <title> Coffee search website </title> 
                  </head>
                  <h1>Hello World!</h1>
                  <hr/>
                  <h2>I'm a Teapot</h2>
                  <pre>
                               ;,'
                       _o_    ;:;'
                   ,-.'---`.__ ;
                  ((j`=====',-'
                   `-\     /
                      `-=-'     hjw
                  </pre>
                  <hr/>
                  <i>Made with<s>out</s> love with Terraform</i>

                  EOL
                  nohup busybox httpd -f -p 8080 index.html > /dev/null &
                  EOF
                  
  tags = {
    Name = "learn-terraform"
  }
}

