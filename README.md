# Pterodactyl ASA Cluster Setup Script

This script automates the setup of ASA Cluster for Pterodactyl by:
- Creating the cluster directory.
- Configuring the `wings` daemon to allow mounting.
- Restarting the `wings` service.

## Prerequisites
- Root or `sudo` access.
- A running Pterodactyl wings instance.

## Usage
1. Clone and run the script in a single command:
   ```bash
   git clone https://github.com/yourusername/asa-cluster-setup.git && cd asa-cluster-setup && bash enable_asa_cluster.sh
