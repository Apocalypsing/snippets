:: 𝗣𝘂𝗻𝗸𝗕𝘂𝘀𝘁𝗲𝗿 𝗦𝗲𝗿𝘃𝗶𝗰𝗲 𝗖𝗼𝗻𝘁𝗿𝗼𝗹
:: Version 𝟭.𝟬
:: Created by 𝗔𝗽𝗼𝗰𝗮𝗹𝘆𝗽𝘀𝗶𝗻𝗴
:: PunkBuster is an anti-cheat used by some older multiplayer games on Windows. It is always running in the background as two Windows services, both with system-level privileges, so it's a potentially big security risk if left unattended like this. I created this batch script to freely toggle it, allowing the services to be safely disabled when not playing a PunkBuster-protected game.

@echo off
set ServiceNameA=PnkBstrA
set ServiceNameB=PnkBstrB
set ServicePathA="C:\Windows\SysWOW64\PnkBstrA.exe"
set ServicePathB="C:\Windows\SysWOW64\PnkBstrB.exe"
title PunkBuster Service Control

:EnableServices
if exist %ServicePathA% (
    echo Enabling %ServiceNameA% service . . .
    sc config %ServiceNameA% start=demand >nul
    echo Starting %ServiceNameA% service . . .
    sc start %ServiceNameA% >nul
)

if exist %ServicePathB% (
    echo Enabling %ServiceNameB% service . . .
    sc config %ServiceNameB% start=demand >nul
    echo Starting %ServiceNameB% service . . .
    sc start %ServiceNameB% >nul
)
echo Services enabled. Press any key to disable.
pause >nul

if exist %ServicePathA% (
    echo Stopping %ServiceNameA% service . . .
    sc stop %ServiceNameA% >nul
    echo Disabling %ServiceNameA% service . . .
    sc config %ServiceNameA% start=disabled >nul
)

if exist %ServicePathB% (
    echo Stopping %ServiceNameB% service . . .
    sc stop %ServiceNameB% >nul
    echo Disabling %ServiceNameB% service . . .
    sc config %ServiceNameB% start=disabled >nul
)
echo Services disabled. Press any key to re-enable.
pause >nul
goto EnableServices
