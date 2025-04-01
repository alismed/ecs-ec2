# Profile
# - 'github-actions' is the github actions profile
# - 'localstack' is the localstack profile
# - 'default' is the default profile
profile            = "github-actions"
region             = "us-east-1"
vpc_id             = "vpc-0bbb42131ef1b5ad7"
availability_zones = ["us-east-1a", "us-east-1c"]
ami                = "ami-02a53b0d62d37a757"
instance_type      = "t2.micro"
key_name           = "terraform-keypair"
destroy_infra      = true

tags = {
  Environment = "dev"
  Description = "API infraestructure"
  Department  = "Engineering"
}