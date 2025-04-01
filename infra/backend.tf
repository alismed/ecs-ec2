terraform {
  backend "s3" {
    bucket  = "alismed-terraform"
    key     = "ecs-ec2/terraform.tfstate"
    region  = "us-east-1" // Must be a static value
    encrypt = true
  }
}
