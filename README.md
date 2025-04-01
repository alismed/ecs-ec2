# API using AWS ECS Cluster on EC2 with Terraform and GitHub Actions
This project demonstrates how to create a Python API and deploy it to AWS ECS on EC2 using Terraform for infrastructure provisioning and GitHub Actions.

## Project Overview
The application consists of:
- Flask REST API
- AWS ECS instance for hosting
- Terraform scripts for infrastructure management
- CI/CD pipeline using GitHub Actions

### Installing dependencies

To install the dependencies, run the following command:

```bash
virtualenv env
source env/bin/activate
pip install -r requirements.txt
```

### Running the application locally

To run the application locally, execute:

```bash
python app/main.py
```

The application will be available at: http://localhost:8080

### Testing with curl

You can test the endpoints using the following curl commands:

```bash
# Test GET / endpoint
curl http://localhost:8080/

# Test GET /get endpoint
curl http://localhost:8080/get

# Test POST /post endpoint
curl -X POST \
     -H "Content-Type: application/json" \
     -d '{"key":"value"}' \
     http://localhost:8080/post
```

### Executing unit tests

To run the tests execute the following commands:

```bash
# Run tests with coverage report
python -m pytest --cov=app app/tests/

# Run tests without coverage
python -m pytest app/tests/
```