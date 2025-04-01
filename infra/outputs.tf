output "public_ip" {
  value = aws_instance.ec2.public_ip
}

output "instance_id" {
  value = aws_instance.ec2.id
}

output "ami" {
  value = aws_instance.ec2.ami
}

output "key_name" {
  value = aws_instance.ec2.key_name
}
output "vpc_id" {
  value = aws_instance.ec2.vpc_security_group_ids
}

output "security_group_id" {
  value = aws_security_group.backend.id
}

output "security_group_name" {
  value = aws_security_group.backend.name
}

