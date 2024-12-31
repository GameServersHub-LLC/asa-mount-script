#!/bin/bash

# Create test environment
TEST_DIR="./test_env"
mkdir -p "$TEST_DIR"

# Create mock config file
cat > "$TEST_DIR/config.yml" << EOL
system:
  root_directory: /var/lib/pterodactyl
allowed_mounts: []
remote: tcp://0.0.0.0:8080
EOL

# Create mock systemctl command
cat > "$TEST_DIR/mock_systemctl" << EOL
#!/bin/bash
echo "Mock systemctl called with: \$@"
EOL
chmod +x "$TEST_DIR/mock_systemctl"

# Modify the script temporarily for testing
sed -e "s|/etc/pterodactyl/asa_cluster|$TEST_DIR/asa_cluster|g" \
    -e "s|/etc/pterodactyl/config.yml|$TEST_DIR/config.yml|g" \
    -e "s|sudo ||g" \
    -e "s|systemctl|$TEST_DIR/mock_systemctl|g" \
    enable_asa_cluster.sh > "$TEST_DIR/test_enable_asa_cluster.sh"

chmod +x "$TEST_DIR/test_enable_asa_cluster.sh"

# Run the test
echo "Running test script..."
bash "$TEST_DIR/test_enable_asa_cluster.sh"

# Verify results
echo -e "\nTest Results:"
echo "1. Checking if cluster directory was created:"
ls -la "$TEST_DIR/asa_cluster"

echo -e "\n2. Checking config.yml contents:"
cat "$TEST_DIR/config.yml"

# Cleanup
read -p $'\nDo you want to clean up the test environment? (y/n) ' -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -rf "$TEST_DIR"
    echo "Test environment cleaned up."
fi
