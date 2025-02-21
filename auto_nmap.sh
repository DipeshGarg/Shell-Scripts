#!/bin/bash

# Set your Discord Webhook URL
WEBHOOK_URL="https://discord.com/api/webhooks/1342069432238997545/QA4k-l47FG2QPJHlbNKgFuondzUp5NDBeUFBzVIAemj8UU4h8YqmMKwtoXE3stx7q10j"

# Path to file containing targets (one per line)
TARGET_FILE="targets.txt"

# Nmap command to run
NMAP_OPTIONS="-sV -v -p1-1000 -T4 -Pn --script=default,http-slowloris-check,http-vuln-cve2011-3192,ssl-dh-params,ssl-enum-ciphers"

# Function to send messages to Discord
send_message() {
    TIMESTAMP=$(date +"%I:%M %p")
    MESSAGE="**$1 ($TIMESTAMP)**\n\`\`\`\n$2\n\`\`\`"
    curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"$MESSAGE\"}" "$WEBHOOK_URL"
}

# Read target file and perform scans
while IFS= read -r TARGET; do
    if [[ -z "$TARGET" ]]; then
        continue  # Skip empty lines
    fi

    LOG_FILE="nmap_scan_$TARGET.log"
    
    nmap $NMAP_OPTIONS $TARGET -oA nmap_$TARGET | tee "$LOG_FILE" &
    NMAP_PID=$!
 
    sleep 5  # Small delay to capture initial output
    LAST_LINE=$(tail -n1 "$LOG_FILE")
    send_message "Nmap Scan Started" "Scanning: $TARGET\n$LAST_LINE"

    while kill -0 $NMAP_PID 2>/dev/null; do
        sleep 30  # Send updates every hour
        LAST_LINE=$(tail -n1 "$LOG_FILE")
        send_message "Nmap Scan Update" "Scanning $TARGET: $LAST_LINE"
    done

    send_message "Scan Completed" "Scan finished for: $TARGET"

done < "$TARGET_FILE"
