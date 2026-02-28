#!/bin/bash
set -e
exec > /var/log/user-data.log 2>&1

echo "=== Starting Jenkins Setup ==="

# Update system
yum update -y


echo "=== Jenkins Setup Complete ==="
echo "Access Jenkins at http://<public-ip>:8080/jenkins"
