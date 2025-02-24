@echo off
setlocal enabledelayedexpansion

:: Set your Discord Webhook URL
set WEBHOOK_URL=YOUR_DISCORD_WEBHOOK_URL

:: List of input files
set targets=Svr01 Svr02 Svr03 Svr04 Svr05 Svr06 Svr07

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

    :: Run Nmap and save output to log file
    nmap.exe -T4 -sV -p- -Pn -v -iL %%i.txt -oA nmap_%%i --script default,http-slowloris-check,http-vuln-cve2011-3192,ssl-dh-params,ssl-enum-ciphers > !LOG_FILE!

    :: Send scan completion message to Discord
    call :send_message "**Nmap Scan Completed for %%i**"

    echo Scan for %%i completed!
    echo -----------------------------------------
)

echo All scans completed!
call :send_message "**All Nmap scans completed!**"
exit /b
