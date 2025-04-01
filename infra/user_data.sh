#!/bin/bash

# Enable detailed logging
set -e
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Update system
sudo yum update -y
sudo yum install -y docker

# Configure docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -a -G docker ec2-user

# Wait for docker service to be active
sudo systemctl --wait is-active docker

# Run container
sudo docker pull alismed/api-ec2:latest
sudo docker run -p 80:8080 --restart always -d alismed/api-ec2:latest