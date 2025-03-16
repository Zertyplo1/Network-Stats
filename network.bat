@echo off
title Network Stats
echo Loading Network Information...
chcp 65001 >nul
color 5

:loop
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "SSID" ^| findstr /v "BSSID"') do set ssid=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "Description"') do set adapter=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "State"') do set state=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "Signal"') do set signal=%%a
ping -n 3 8.8.8.8>%temp%\ping.txt
for /f "tokens=4 delims==" %%a in ('type %temp%\ping.txt ^| find "Average"') do set ping=%%a
for /f "tokens=10 delims= " %%a in ('type %temp%\ping.txt ^| find "Lost"') do set ploss=%%a
for /f "tokens=2 delims= " %%a in ('netstat -e ^| find "Bytes"') do set rbytes=%%a
for /f "tokens=3 delims= " %%a in ('netstat -e ^| find "Bytes"') do set sbytes=%%a
cls
:start
call :banner

echo.
echo  Network:
echo  --------
echo  SSID:%ssid%
echo  NIC:%adapter%
echo  State:%state%
echo  Signal:%signal%
echo.
echo  Speed:
echo  ------
echo  Ping:%ping%
echo  Packet Loss: %ploss%
echo  Received: %rbytes% Bytes
echo  Sent: %sbytes% Bytes
goto loop

:banner
echo.
echo.
echo ▐ ▄ ▄▄▄ .▄▄▄▄▄▄▄▌ ▐ ▄▌      ▄▄▄  ▄ •▄     ▄▄▄▄▄            ▄▄▌  
echo •█▌▐█▀▄.▀·•██  ██· █▌▐█▪     ▀▄ █·█▌▄▌▪    •██  ▪     ▪     ██•  
echo ▐█▐▐▌▐▀▀▪▄ ▐█.▪██▪▐█▐▐▌ ▄█▀▄ ▐▀▀▄ ▐▀▀▄·     ▐█.▪ ▄█▀▄  ▄█▀▄ ██▪  
echo ██▐█▌▐█▄▄▌ ▐█▌·▐█▌██▐█▌▐█▌.▐▌▐█•█▌▐█.█▌     ▐█▌·▐█▌.▐▌▐█▌.▐▌▐█▌▐▌
echo ▀▀ █▪ ▀▀▀  ▀▀▀  ▀▀▀▀ ▀▪ ▀█▄▀▪.▀  ▀·▀  ▀     ▀▀▀  ▀█▄▀▪ ▀█▄▀▪.▀▀▀ 
echo.
echo.