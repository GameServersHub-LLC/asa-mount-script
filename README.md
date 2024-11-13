# Pterodactyl ASA Cluster Setup Script

This script automates the setup of ASA Cluster for Pterodactyl by:
- Creating the cluster directory.
- Configuring the `wings` daemon to allow mounting.
- Restarting the `wings` service.

## Prerequisites
- Root or `sudo` access.
- A running Pterodactyl wings instance.

## Usage
1. Clone the repository:
   ```bash
   git clone https://github.com/GameServersHub-LLC/asa-mount-script.git
   cd asa-cluster-setup
