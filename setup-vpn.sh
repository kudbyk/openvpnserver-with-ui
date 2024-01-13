#!/bin/bash

# Check if running with sudo
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script with sudo. Example: sudo $0"
    exit 1
fi

# Install Docker
sudo apt update
sudo apt install -y docker.io docker-compose awk

# Clone the OpenVPN configuration
git clone https://github.com/janamkhatiwada/openvpnserver-with-ui.git
cd openvpnserver-with-ui


# Run Docker Compose
docker-compose up -d

# Extract the admin password from docker-compose.yml
admin_password=$(awk '/OPENVPN_ADMIN_PASSWORD/ {print $2}' docker-compose.yml | tr -d '"' | tr -d '\n')

# Echo the admin password
echo "Password for admin is: $admin_password"