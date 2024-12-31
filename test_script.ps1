# Create test environment
$TEST_DIR = ".\test_env"
New-Item -ItemType Directory -Force -Path $TEST_DIR

# Create mock config file
@"
system:
  root_directory: /var/lib/pterodactyl
allowed_mounts: []
remote: tcp://0.0.0.0:8080
"@ | Set-Content "$TEST_DIR\config.yml"

# Create mock systemctl command
@"
echo "Mock systemctl called with: `$args"
"@ | Set-Content "$TEST_DIR\mock_systemctl.ps1"

# Get the absolute path and convert to WSL format
$currentPath = (Get-Location).Path
$wslPath = wsl wslpath -a ($currentPath -replace "\\", "/")

# Modify the script for testing
$script = Get-Content "enable_asa_cluster.sh" -Raw
$script = $script -replace "`r`n", "`n"  # Convert CRLF to LF
$script = $script -replace "/etc/pterodactyl/asa_cluster", "./asa_cluster"
$script = $script -replace "/etc/pterodactyl/config.yml", "./config.yml"
$script = $script -replace "sudo ", ""
$script = $script -replace "systemctl", "./mock_systemctl.ps1"
# Ensure LF line endings when writing the file
[System.IO.File]::WriteAllText("$TEST_DIR\test_enable_asa_cluster.sh", $script, [System.Text.Encoding]::UTF8)

# Attempt to automatically detect and use available shell
$gitBashPath = 'C:\Program Files\Git\bin\bash.exe'
$command = ""

if (Get-Command wsl -ErrorAction SilentlyContinue) {
    Write-Host "Using WSL to execute test..."
    $command = "wsl"
} elseif (Test-Path $gitBashPath) {
    Write-Host "Using Git Bash to execute test..."
    $command = $gitBashPath
} else {
    Write-Host "Error: Neither WSL nor Git Bash found. Please install one of them to run the test."
    exit 1
}

# Execute the test script
if ($command -eq "wsl") {
    Write-Host "Running test in WSL from directory: $wslPath/test_env"
    & wsl bash -c "cd '$wslPath/test_env' && bash ./test_enable_asa_cluster.sh"
} else {
    $gitBashPath = $gitBashPath -replace "\\", "/"
    Write-Host "Running test in Git Bash from directory: $TEST_DIR"
    & $command -c "cd '$TEST_DIR' && bash ./test_enable_asa_cluster.sh"
}

# Wait a moment for file operations to complete
Start-Sleep -Seconds 2

# Verify results
Write-Host "`nTest Results:"
Write-Host "1. Checking if cluster directory was created:"
if (Test-Path "$TEST_DIR\asa_cluster") {
    Get-ChildItem "$TEST_DIR\asa_cluster"
} else {
    Write-Host "Cluster directory was not created!"
}

Write-Host "`n2. Checking config.yml contents:"
Get-Content "$TEST_DIR\config.yml"

# Cleanup prompt
$response = Read-Host "`nDo you want to clean up the test environment? (y/n)"
if ($response -eq 'y') {
    Remove-Item -Recurse -Force $TEST_DIR
    Write-Host "Test environment cleaned up."
}
