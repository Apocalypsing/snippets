:: 𝗡𝗲𝘁𝘄𝗼𝗿𝗸 𝗖𝗼𝗻𝗻𝗲𝗰𝘁𝗶𝗼𝗻 𝗠𝗼𝗻𝗶𝘁𝗼𝗿
:: Version 𝟭.𝟬
:: Created by 𝗔𝗽𝗼𝗰𝗮𝗹𝘆𝗽𝘀𝗶𝗻𝗴
:: This Windows batch script will monitor a specified network interface for Internet connectivity. If this interface goes down, the script will automatically fail over to a backup interface. Tether your phone to your computer, and this script will act as a quick and dirty fix for unstable Internet connections.

@echo off
title Network Connection Monitor

if not exist "NetworkConnectionMonitor.ini" (
	echo NetworkConnectionMonitor.ini is missing; creating it and appending defaults.
    echo EthernetName="Ethernet" > NetworkConnectionMonitor.ini
    echo HotspotName="iPhone" >> NetworkConnectionMonitor.ini
    echo EthernetAddress=192.168.1.40 >> NetworkConnectionMonitor.ini
    echo GatewayAddress=1.1.1.1 >> NetworkConnectionMonitor.ini
    echo LossThreshold=5 >> NetworkConnectionMonitor.ini
    echo SampleRate=2 >> NetworkConnectionMonitor.ini
    echo ReconnectDelay=15 >> NetworkConnectionMonitor.ini
)

echo Please connect your phone and turn on personal hotspot before continuing.
set UnsuccessfulPings=0
for /f "delims=" %%x in (NetworkConnectionMonitor.ini) do (set "%%x")
pause
ipconfig /renew %EthernetName% > nul
echo [%Date% %Time%] Monitoring started > NetworkConnectionMonitor.log

:ping
ping -n 1 -w 1000 %GatewayAddress% -S %EthernetAddress% | find "bytes="
if %ErrorLevel% equ 0 (
    set UnsuccessfulPings=0
    ipconfig /release %HotspotName% > nul
) else (
    set /a UnsuccessfulPings=UnsuccessfulPings+1
    echo Request timed out.
    echo [%Date% %Time%] Request timed out. >> NetworkConnectionMonitor.log
)
if %UnsuccessfulPings% equ %LossThreshold% (
    ipconfig /release %EthernetName% > nul
    goto restart
)
timeout /t %SampleRate% /nobreak > nul
goto ping

:restart
echo [%Date% %Time%] Loss threshold reached! %EthernetName% is likely down, attempting failover to %HotspotName%...  
echo [%Date% %Time%] Loss threshold reached! %EthernetName% is likely down, attempting failover to %HotspotName%... >> NetworkConnectionMonitor.log
set UnsuccessfulPings=0
ipconfig /renew %HotspotName% > nul
echo Reconnecting in %ReconnectDelay% seconds...
timeout /t %ReconnectDelay% /nobreak > nul
ipconfig /renew %EthernetName% > nul
goto ping
