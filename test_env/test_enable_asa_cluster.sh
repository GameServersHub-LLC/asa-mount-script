#!/bin/bash

# Pterodactyl ASA Cluster Setup Script
# This script automates the process of enabling mounting for Pterodactyl ASA Cluster.
# Author: Mike H
# Date: 2024-11-13

# Exit on error
set -e

# Variables
CLUSTER_DIR="./asa_cluster"
WINGS_CONFIG="./config.yml"
MOUNT_ENTRY="  - ./asa_cluster"  # Single space indentation

# Functions
create_cluster_directory() {
    echo "Creating cluster directory at $CLUSTER_DIR..."
    mkdir -p "$CLUSTER_DIR"
    chown pterodactyl:pterodactyl "$CLUSTER_DIR"
    echo "Cluster directory created and permissions set."
}

edit_wings_config() {
    echo "Editing wings configuration file..."
    if grep -q "allowed_mounts: \[\]" "$WINGS_CONFIG"; then
        # Replace empty array with properly formatted mount entry
        sed -i "/allowed_mounts: \[\]/c\allowed_mounts:\n$MOUNT_ENTRY" "$WINGS_CONFIG"
        echo "Configuration updated to allow mounting for $CLUSTER_DIR."
    elif ! grep -q "$(echo "$MOUNT_ENTRY" | sed 's/[][\.*^$/]/\\&/g')" "$WINGS_CONFIG"; then
        # Find the allowed_mounts line and append the new mount entry
        sed -i '/allowed_mounts:/a\'"$MOUNT_ENTRY" "$WINGS_CONFIG"
        echo "Mount entry added to configuration."
    else
        echo "Mount entry already exists in configuration."
    fi
}

restart_wings_service() {
    echo "Restarting wings service..."
    ./mock_systemctl.ps1 restart wings
    echo "Wings service restarted successfully."
}

# Main Script Execution
echo "Starting ASA Cluster setup for Pterodactyl..."
create_cluster_directory
edit_wings_config
restart_wings_service
echo "ASA Cluster setup completed successfully."
