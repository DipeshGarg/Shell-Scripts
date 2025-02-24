@echo off
setlocal enabledelayedexpansion

:: Set your Discord Webhook URL
set WEBHOOK_URL=YOUR_DISCORD_WEBHOOK_URL

:: List of input files
set targets=Svr01 Svr02 Svr03

:: Function to send message to Discord
:send_message
echo Sending message to Discord: %1
curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"%1\"}" %WEBHOOK_URL%
exit /b

:: Loop through each target file
for %%i in (%targets%) do (
    set LOG_FILE=nmap_%%i.log
    echo Running Nmap scan for %%i...

    :: Send scan started message to Discord
    call :send_message "**Nmap Scan Started for %%i**"

    :: Run Nmap and output to log file (run in the background)
    nmap.exe -T4 -sV -p- -Pn -v -iL %%i.txt -oA nmap_%%i --script default,http-slowloris-check,http-vuln-cve2011-3192,ssl-dh-params,ssl-enum-ciphers > !LOG_FILE! 2>&1 &
    
    :: Wait a few seconds to ensure the log file starts writing
    timeout /t 5 /nobreak >nul

    :: Monitor the log file for updates every hour
    :monitor_progress
    if not exist "!LOG_FILE!" goto done_scanning
    for /f "tokens=*" %%j in ('type "!LOG_FILE!" ^| findstr /r /c:"."') do set LAST_LINE=%%j
    call :send_message "**Nmap Scan Update for %%i:** `!LAST_LINE!`"
    
    :: Wait for an hour before checking again
    timeout /t 3600 /nobreak >nul
    goto monitor_progress

    :done_scanning
    :: Send scan completion message to Discord
    call :send_message "**Nmap Scan Completed for %%i**"

    echo Scan for %%i completed!
    echo -----------------------------------------
)

echo All scans completed!
call :send_message "**All Nmap scans completed!**"
exit /b
