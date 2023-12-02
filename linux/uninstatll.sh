#!/bin/bash

# Function to remove crestic@.service and crestic@.timer
remove_services() {
    if [ "$1" == "system" ]; then
        sudo rm /etc/systemd/system/crestic@.service
        sudo rm /etc/systemd/system/crestic@.timer
    elif [ "$1" == "user" ]; then
        rm ~/.config/systemd/user/crestic@.service
        rm ~/.config/systemd/user/crestic@.timer
    else
        echo "Invalid installation type."
        exit 1
    fi
}

# Ask for uninstallation type
read -ep "Choose uninstallation type (system/user): " uninstall_type

# Remove services based on uninstallation type
remove_services "$uninstall_type"

# Optionally restart systemd daemon
read -ep "Do you want to restart systemd daemon? (y/n): " restart_choice

if [ "$restart_choice" == "y" ]; then
    sudo systemctl daemon-reload
    echo "Systemd daemon has been restarted."
else
    echo "Systemd daemon not restarted."
fi

echo "Uninstallation completed successfully."
