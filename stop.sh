#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Check if the PID file exists
if [ -f "whook.pid" ]; then
    # Read the PID from the file
    PID=$(cat whook.pid)
    
    # Check if the process is still running
    if ps -p $PID > /dev/null; then
        echo "Stopping trading bot with PID $PID..."
        # Send SIGTERM to the process
        kill -15 $PID
        
        # Wait for the process to terminate
        while kill -0 $PID 2>/dev/null; do 
            sleep 1
        done
        
        echo "Trading bot has been stopped."
    else
        echo "No running trading bot found with PID $PID"
    fi
    
    # Remove the PID file
    rm -f whook.pid
else
    echo "No PID file found. Is the bot running?"
    echo "You can check for any remaining Python processes with: ps aux | grep 'python3 main.py'"
fi
