@echo off
REM Executa o script PowerShell de download interativo
SET SCRIPT_DIR=%~dp0
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%download_calculator.ps1"
