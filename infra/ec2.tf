/*
resource "aws_instance" "ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.backend.id]
  user_data              = file(var.user_data_path)

  tags = var.instance_tags
}
*/