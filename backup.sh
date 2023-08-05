#!/bin/bash

# Check if preset argument was supplied, exit if not
# from: https://stackoverflow.com/questions/6482377/check-existence-of-input-argument-in-a-bash-shell-script
if [ -z "$1" ]
  then
    echo "No preset argument supplied, exiting"
    notify-send "No preset argument supplied, backup failed"
    exit 1
fi

# Save preset argument to variable
PRESET=$1

timestamp() {
  date "+%Y-%m-%d_%H:%M"
}

export CONFIG_DIRECTORY=${XDG_CONFIG_HOME:-~/.config}/crestic/
export LOG_FILE=$CONFIG_DIRECTORY/logs/$(timestamp)_$PRESET.log

# Ensure correct config is read, even when running as different user
export CRESTIC_CONFIG_FILE=$CONFIG_DIRECTORY/config.cfg

# Create logs directory in case it doesn't exist
mkdir -p $CONFIG_DIRECTORY/logs
# Create log file
touch $LOG_FILE

echo "==== Configuration options ====" | tee -a $LOG_FILE
echo "Running as $USER" | tee -a $LOG_FILE
echo "Preset: $PRESET" | tee -a $LOG_FILE

echo "==== Running backup... ====" | tee -a $LOG_FILE
crestic $PRESET backup | tee -a $LOG_FILE
echo "==== Running forget and prune... ====" | tee -a $LOG_FILE
crestic $PRESET forget | tee -a $LOG_FILE
echo "==== Running check... ====" | tee -a $LOG_FILE
crestic $PRESET check | tee -a $LOG_FILE
echo "==== Backup done! ====" | tee -a $LOG_FILE

# Run only if command exists (in case of a headless system)
if command -v apprise >/dev/null 2>&1; then
    apprise --config=$CONFIG_DIRECTORY/apprise.yaml -t 'Crestic backup routine' -b 'Backup completed, go check logs for errors' --tag $PRESET
fi
