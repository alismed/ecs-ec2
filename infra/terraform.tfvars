# Profile
# - 'github-actions' is the github actions profile
# - 'localstack' is the localstack profile
# - 'default' is the default profile
profile            = "github-actions"
region             = "us-east-1"
vpc_id             = "vpc-0bbb42131ef1b5ad7"
cluster_name       = "my-ecs-cluster"
service_name       = "my-ecs-service"
subnet_ids         = ["subnet-0c56f6efbe2fec4de", "subnet-0ac630be8257bccc9"]
instance_type      = "t2.micro"
key_name           = "ecs-keypair"
container_image    = "alismed/ecs-ec2:latest"
destroy_infra      = false

tags = {
  Environment = "dev"
  Description = "API infraestructure"
  Department  = "Engineering"
}