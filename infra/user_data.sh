#!/bin/bash

# Enable detailed logging
set -e
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Update system
echo "[INFO] Updating system packages"
sudo yum update -y

# Install Docker
echo "[INFO] Installing Docker"
sudo amazon-linux-extras install -y docker
sudo systemctl start docker
sudo systemctl enable docker

# Create ECS directories
mkdir -p /var/log/ecs
mkdir -p /etc/ecs

# Update system and install SSM agent (if not already installed)
sudo yum install -y amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

# Install and configure ECS agent
echo "[INFO] Installing ECS agent"
sudo amazon-linux-extras install ecs -y
sudo systemctl enable --now ecs

# Configure ECS cluster
echo "[INFO] Configuring ECS cluster"
mkdir -p /etc/ecs
cat << EOF > /etc/ecs/ecs.config
ECS_CLUSTER=${cluster_name}
ECS_LOGLEVEL=info
ECS_ENABLE_TASK_IAM_ROLE=true
ECS_ENABLE_CONTAINER_METADATA=true
ECS_AVAILABLE_LOGGING_DRIVERS=["json-file","awslogs"]
EOF

# Enable and start ECS agent
echo "[INFO] Starting ECS agent"
sudo systemctl restart ecs
