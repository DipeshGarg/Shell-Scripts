#!/bin/bash

# Set your Discord Webhook URL
WEBHOOK_URL="https://discord.com/api/webhooks/1341723445901394021/Ltdrzmct8AMCQQuDIbJP6fEofZDuI_DEmuExQzHewbrbBAGUFBQ1lvpVS5PARGlGESWW"

# Define the nmap command (modify this as needed)
NMAP_COMMAND="nmap -T4 -p22,8000 10.10.235.128 -oA nmap_test_THm"

# Define a log file to track scan progress
LOG_FILE="/tmp/nmap_scan.log"

# Run the nmap command and output to the log file while displaying it on screen
$NMAP_COMMAND | tee -a "$LOG_FILE" 2>&1 &
NMAP_PID=$!

echo "Started Nmap scan with PID: $NMAP_PID"

# Function to send updates to Discord
send_update() {
    TIMESTAMP=$(date +"%I:%M %p")
    LAST_LINES=$(tail -n1 "$LOG_FILE")
    FORMATTED_MESSAGE="**Nmap Scan Update: ($TIMESTAMP)**\n\`\`\`\n$LAST_LINES\n\`\`\`"
    curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$FORMATTED_MESSAGE\"}" "$WEBHOOK_URL"
}

# Function to send scan completion update
send_completion_update() {
    TIMESTAMP=$(date +"%I:%M %p")
    COMPLETION_MESSAGE="**Scan Completed: ($TIMESTAMP)**\n\`\`\`\nScan has finished successfully.\n\`\`\`"
    curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$COMPLETION_MESSAGE\"}" "$WEBHOOK_URL"
}


# Run every hour using cron, add this line by running `crontab -e`
# 0 * * * * /path/to/nmap_status.sh

# Loop to send updates every hour
while kill -0 $NMAP_PID 2>/dev/null; do
    send_update
    sleep 30  # Wait an hour before sending the next update
done

# Final update after scan completes
send_update
send_completion_update
