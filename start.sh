#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Activate virtual environment if it exists
if [ -d "venv" ]; then
    source venv/bin/activate
fi

# Create logs directory if it doesn't exist
mkdir -p logs

# Generate a timestamp for the log file
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_FILE="logs/whook_${TIMESTAMP}.log"

# Start the bot in the background and save the PID
echo "Starting the trading bot..."
nohup python3 main.py >> "$LOG_FILE" 2>&1 &
echo $! > whook.pid

echo "Trading bot started with PID $(cat whook.pid)"
echo "Logs are being written to: $LOG_FILE"
echo "To stop the bot, run: ./stop.sh"
