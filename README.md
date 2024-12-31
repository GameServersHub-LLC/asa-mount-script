# Pterodactyl ASA Cluster Setup Script

## Purpose
This script automates the configuration required for ARK: Survival Ascended (ASA) cluster setups on Pterodactyl. It enables cross-communication between different ASA server instances by:

1. Creating a shared directory (`/etc/pterodactyl/asa_cluster`) where servers can exchange cluster data
2. Configuring Pterodactyl's wings daemon to allow safe mounting of this directory
3. Setting proper permissions so your ASA servers can read/write cluster data
4. Automatically restarting the wings service to apply changes

## Benefits
- Enables cross-server travel between your ASA instances
- Allows players to transfer characters and items between servers
- Maintains consistent cluster data across all your ASA servers
- Eliminates manual configuration errors

## Prerequisites
- Linux system with root or `sudo` access
- Running Pterodactyl wings instance

## Quick Install
Run this single command:

Using curl:
```bash
curl -sSL https://github.com/GameServersHub-LLC/asa-cluster-setup/raw/main/enable_asa_cluster.sh | sudo bash
```
