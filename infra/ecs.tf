resource "aws_ecs_cluster" "my_cluster" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = var.tags
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}


resource "aws_launch_template" "my_launch_template" {
  name          = "my-launch-template"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.keypair.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_agent.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.backend.id]
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 10
      volume_type = "gp3"
    }
  }

  user_data = base64encode(templatefile(var.user_data_path, {
    cluster_name = aws_ecs_cluster.my_cluster.name
  }))

  tag_specifications {
    resource_type = "instance"
    tags          = var.instance_tags
  }
}


resource "aws_autoscaling_group" "my_asg" {
  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = "$Latest"
  }

  min_size         = 1
  max_size         = 3
  desired_capacity = 2

  vpc_zone_identifier = var.subnet_ids

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

resource "aws_ecs_task_definition" "my_task" {
  family                   = "my-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "my-container"
      image     = var.container_image
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = var.http_port
          hostPort      = var.http_port
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "my_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  desired_count   = 1
  launch_type     = "EC2"
  depends_on      = [aws_autoscaling_group.my_asg]
}

resource "aws_iam_role" "ecs_agent" {
  name = "ecs-agent"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_agent" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ecs_agent_ssm" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ecs_agent" {
  name = "ecs-agent"
  role = aws_iam_role.ecs_agent.name
}


