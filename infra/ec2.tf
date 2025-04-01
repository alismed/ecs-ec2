resource "aws_security_group" "backend" {
  name        = "backend"
  description = "http access"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.backend.id]
  user_data              = file("user_data.sh")
}