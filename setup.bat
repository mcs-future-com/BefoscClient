@echo off

setlocal enabledelayedexpansion

rem 管理者権限で実行
openfiles > nul

if "%1"=="" (
set arg=
) else (
set arg= -ArgumentList "%1"
)
if errorlevel 1 (
   PowerShell.exe -Command Start-Process \"%~f0\"%arg% -Verb runas
   exit
)

cd /d %~dp0

certutil.exe -p befosc -importpfx ROOT %current_path%BefoscClient.pfx

certutil.exe -p befosc -importpfx TRUSTEDPUBLISHER %current_path%BefoscClient.pfx

call %current_path%setup.exe
