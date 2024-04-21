
variable "instance_type" {}
variable "ami" {}
variable "key_name" {}
variable "vpc_id" {}

resource "aws_instance" "web_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_server.id]
  key_name               = var.key_name
  tags = {
    Name = "HelloWorldWebServerInstance"
  }
}

resource "aws_security_group" "web_server" {
  name        = "web_server_sg"
  description = "Allow inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "web_elb" {
  name            = "web-server-elb"
  security_groups = [aws_instance.web_server.id]
  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }
}

resource "aws_autoscaling_group" "web_server" {
  name = "web_server_asg"
  launch_configuration = aws_launch_configuration.web_server.name
  max_size = 2
  min_size = 1
  vpc_zone_identifier = [ aws_subnet.public.id ]
}

resource "aws_launch_configuration" "web_server" {
  image_id = var.ami
    instance_type = var.instance_type
    security_groups = [ aws_security_group.web_server.id ]
    key_name = var.key_name
}

resource "aws_subnet" "public" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = var.vpc_id
  availability_zone = "ap-northeast-2a"
}

output "instance_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "elb_dns_name" {
  value = aws_elb.web_elb.dns_name
}