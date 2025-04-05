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

output "autoscaling_group" {
  value = aws_autoscaling_group.my_asg.id
}

output "launch_template_id" {
  value = aws_launch_template.my_launch_template.id
}
