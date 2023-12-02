#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install crestic@.service and crestic@.timer
install_services() {
    if [ "$1" == "system" ]; then
        sudo cp "$SCRIPT_DIR/crestic@.service" /etc/systemd/system/
        sudo cp "$SCRIPT_DIR/crestic@.timer" /etc/systemd/system/
    elif [ "$1" == "user" ]; then
        cp "$SCRIPT_DIR/crestic@.service" ~/.config/systemd/user/
        cp "$SCRIPT_DIR/crestic@.timer" ~/.config/systemd/user/
    else
        echo "Invalid installation type."
        exit 1
    fi
}

# Function to enable the service
enable_service() {
    if [ "$1" == "system" ]; then
        sudo systemctl enable --now "crestic@$2.timer"
    elif [ "$1" == "user" ]; then
        systemctl --user enable --now "crestic@$2.timer"
    else
        echo "Invalid installation type."
        exit 1
    fi
}

# Ask for installation type
read -ep "Choose installation type (system/user): " install_type

# Check if crestic and restic binaries exist and are accessible
if ! command_exists restic || ! command_exists crestic; then
    echo "crestic or restic binaries not found or not accessible."
    echo "You can find installation instructions here:
    - restic: https://restic.net/
    - crestic: https://github.com/nils-werner/crestic/"
    exit 1
fi

# Install services based on installation type
install_services "$install_type"

# Ask if the user wants to enable the service
read -ep "Do you want to enable the service? (y/n): " enable_service_choice

if [ "$enable_service_choice" == "y" ]; then
    read -ep "Enter preset for the service: " service_preset
    enable_service "$install_type" "$service_preset"
    echo "Service has been enabled."
else
    echo "Service not enabled."
fi

echo "Installation completed successfully."
