#!/bin/bash

# Enable detailed logging
set -e
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Create ECS directories
mkdir -p /var/log/ecs
mkdir -p /etc/ecs

# Configure ECS cluster
echo "[INFO] Configuring ECS cluster"
cat << EOF > /etc/ecs/ecs.config
ECS_CLUSTER=${cluster_name}
ECS_LOGLEVEL=info
ECS_ENABLE_TASK_IAM_ROLE=true
ECS_ENABLE_CONTAINER_METADATA=true
ECS_AVAILABLE_LOGGING_DRIVERS=["json-file","awslogs"]
EOF

# Update system and install SSM agent (if not already installed)
echo "[INFO] Updating system packages"
yum update -y
yum install -y ecs-init

# Starting ECS agent
echo "[INFO] Starting ECS agent"
sudo systemctl stop ecs
sudo systemctl reset-failed ecs
sudo systemctl daemon-reexec
sudo systemctl start ecs
sudo systemctl status ecs

# Check logs
echo "[INFO] Checking ECS agent logs"
sudo journalctl -u ecs
