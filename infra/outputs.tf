/*
output "ami" {
  value = aws_instance.ec2.ami
}

output "public_ip" {
  value = aws_instance.ec2.public_ip
}

output "instance_id" {
  value = aws_instance.ec2.id
}

output "subnet_id" {
  value = aws_instance.ec2.subnet_id
}

output "key_name" {
  value = aws_instance.ec2.key_name
}

output "vpc_id" {
  value = aws_instance.ec2.vpc_security_group_ids
}

*/

output "security_group_id" {
  value = aws_security_group.backend.id
}

output "security_group_name" {
  value = aws_security_group.backend.name
}

output "cluster_name" {
  value = aws_ecs_cluster.my_cluster.name
}

output "service_name" {
  value = aws_ecs_service.my_service.name
}

output "task_definition" {
  value = aws_ecs_task_definition.my_task.arn
}

output "capacity_provider" {
  value = aws_ecs_capacity_provider.my_capacity_provider.name
}

output "autoscaling_group" {
  value = aws_autoscaling_group.my_asg.id
}

output "launch_template_id" {
  value = aws_launch_template.my_launch_template.id
}
