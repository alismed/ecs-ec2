# API using AWS ECS Cluster on EC2 with Terraform and GitHub Actions
This project demonstrates how to create a Python API and deploy it to AWS ECS on EC2 using Terraform for infrastructure provisioning and GitHub Actions.

## Project Overview
The application consists of:
- Flask REST API
- AWS ECS instance for hosting
- Terraform scripts for infrastructure management
- CI/CD pipeline using GitHub Actions

## Requirements

### Local Development
- Python >= 3.12
- AWS CLI
- Terraform CLI
- Docker
- ssh

### AWS Resources
- AWS Account with appropriate permissions
- S3 Bucket for Terraform state (can be created via terraform)

## Setup Instructions

### AWS Configuration
1. Configure AWS CLI credentials:
   ```shell
   aws configure
   ```
2. For LocalStack testing, add profiles in:
   - `.aws/credentials`
   - `.aws/config`
3. Create a ssh key
   ```shell
   ssh-keygen
   ```

### Installing dependencies

To install the dependencies, run the following command:

```shell
virtualenv env
source env/bin/activate
pip install -r requirements.txt
```

### Executing unit tests

To run the tests execute the following commands:

```shell
# Run tests with coverage report
python -m pytest --cov=app app/tests/

# Run tests without coverage
python -m pytest app/tests/
```

### Running the application locally

To run the application locally, execute:

```shell
python app/main.py
```

The application will be available at: http://localhost:8080

### Testing with curl

You can test the endpoints using the following curl commands:

```shell
# Docker run
docker run -d -p 8080:8080 alismed/ecs-ec2:latest

# Test GET / endpoint
curl http://localhost:8080/

# Test GET /get endpoint
curl http://localhost:8080/list

# Test POST /post endpoint
curl -X POST \
     -H "Content-Type: application/json" \
     -d '{"key":"value"}' \
     http://localhost:8080/create
```

### Application Build & Run

*Build the docker image*
```shell
cd app

docker build -t alismed/ecs-ec2:latest .

docker login

docker push alismed/ecs-ec2:latest
```

### Infrastructure Management
```shell
# Initialize Terraform
terraform -chdir=infra init

# Format Terraform files
terraform -chdir=infra fmt

# Plan changes
terraform -chdir=infra plan

# Apply changes
terraform -chdir=infra apply -auto-approve

# Destroy infrastructure
terraform -chdir=infra destroy -auto-approve
```

## GitHub Actions

The workflow is divided into three stages:

1. **Validation (01-validate.yaml)**
    * Validates and reads terraform variables
    * Outputs variables for other stages

2. **Terraform Execution (02-terraform.yaml)**
    * Configures AWS credentials
    * Executes terraform init/plan/apply or destroy

3. **PR Notification (03-notify.yaml)**
    * Posts results back to the Pull Request
    * Formats success/failure messages

All stages are orchestrated by `main.yaml` which ensures proper execution order and data flow between stages.


## Testing GitHub Actions Locally

### Using Act
1. Install Act:
```bash
curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
```

2. Setup test environment:
```bash
# Create test directory if not exists
mkdir -p .act

# Create env file with credentials
echo "AWS_ACCESS_KEY_ID=test" > .act/.env
echo "AWS_SECRET_ACCESS_KEY=test" >> .act/.env
echo "AWS_DEFAULT_REGION=us-east-1" >> .act/.env

# Create pull request event simulation
cat > .act/pull_request.json << EOF
{
  "pull_request": {
    "number": 1,
    "body": "Test PR",
    "head": {
      "ref": "feature/test"
    }
  }
}
EOF
```

3. Run workflows locally:
```bash
# List available workflows
act -l

# Run workflow with pull request event
act pull_request -e .act/pull_request.json

# Run specific workflow
act -W .github/workflows/01-validate.yaml -e .act/pull_request.json --secret-file .act/.env

# Run with verbose output
act -v pull_request -e .act/pull_request.json --secret-file .act/.env
```
