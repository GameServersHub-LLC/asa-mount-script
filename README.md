# Pterodactyl ASA Cluster Setup Script

This script automates the setup of ASA (ARK: Survival Ascended) Cluster configuration for Pterodactyl by:
- Creating the cluster directory at `/etc/pterodactyl/asa_cluster`
- Configuring the `wings` daemon to allow mounting
- Setting proper permissions and restarting the service

## Prerequisites
- Linux system with root or `sudo` access
- Running Pterodactyl wings instance

## Quick Install
Choose one of these one-line commands:

Using curl:
```bash
curl -sSL https://github.com/GameServersHub-LLC/asa-cluster-setup/raw/main/enable_asa_cluster.sh | sudo bash
```

Using wget:
```bash
wget -qO- https://github.com/GameServersHub-LLC/asa-cluster-setup/raw/main/enable_asa_cluster.sh | sudo bash
```

## Usage
1. Clone and run the script in a single command:
   ```bash
   git clone https://github.com/GameServersHub-LLC/asa-cluster-setup.git && cd asa-cluster-setup && bash enable_asa_cluster.sh
   ```
