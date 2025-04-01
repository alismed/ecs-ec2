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
  description = "VPC ID"
}

variable "availability_zones" {
  type        = list(string)
  default     = []
  description = "List of availability zones"
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
  default     = ""
  description = "Path to the public key file"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources"
}