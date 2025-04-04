variable "region" {
  type        = string
  default     = ""
  description = "AWS region"
}

variable "profile" {
  type        = string
  description = "AWS profile to use"
  default     = "default"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "VPC ID where resources will be created"
}

variable "ami" {
  type        = string
  default     = ""
  description = "AMI ID"
}

variable "instance_type" {
  type        = string
  default     = ""
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  default     = ""
  description = "Key pair name"
}

variable "public_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa_ecs.pub"
  description = "Path to the public key file"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources"
}

variable "security_group_name" {
  description = "Name for the security group"
  type        = string
  default     = "backend"
}

variable "security_group_description" {
  description = "Description for the security group"
  type        = string
  default     = "http access"
}

variable "http_port" {
  description = "Port for HTTP traffic"
  type        = number
  default     = 8080
}

variable "ssh_port" {
  description = "Port for SSH traffic"
  type        = number
  default     = 22
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed for ingress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_from_port" {
  description = "Starting port for egress traffic"
  type        = number
  default     = 0
}

variable "egress_to_port" {
  description = "Ending port for egress traffic"
  type        = number
  default     = 65535
}

variable "egress_protocol" {
  description = "Protocol for egress traffic"
  type        = string
  default     = "tcp"
}

variable "user_data_path" {
  description = "Path to user data script"
  type        = string
  default     = "user_data.sh"
}

variable "instance_tags" {
  description = "Tags for the EC2 instance"
  type        = map(string)
  default = {
    Name        = "ecs-instance"
    Environment = "dev"
  }
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = ""
}

variable "container_image" {
  description = "Container image for the ECS task"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
  default     = []
}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string
  default     = ""
}
