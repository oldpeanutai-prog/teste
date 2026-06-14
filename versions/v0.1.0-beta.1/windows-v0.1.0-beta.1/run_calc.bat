@echo off
REM Executa o script PowerShell para Windows
SET SCRIPT_DIR=%~dp0
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%run_calc.ps1"
