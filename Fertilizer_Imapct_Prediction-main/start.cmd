@echo off
cd /d "%~dp0"

if exist venv\Scripts\python.exe (
    venv\Scripts\python.exe --version >nul 2>&1
    if errorlevel 1 (
        echo Existing virtual environment is invalid; recreating it...
        rmdir /s /q venv
    )
)

if not exist venv\Scripts\python.exe (
    echo Creating virtual environment...
    py -3 -m venv venv
    if errorlevel 1 (
        echo Failed to create virtual environment.
        pause
        exit /b 1
    )
)

venv\Scripts\python.exe -m ensurepip --upgrade
if errorlevel 1 (
    echo Failed to bootstrap pip in the virtual environment.
    exit /b 1
)

venv\Scripts\python.exe -m pip install -r requirements-server.txt
if errorlevel 1 (
    echo Failed to install server dependencies.
    exit /b 1
)

echo Starting AgriNexus server...
venv\Scripts\python.exe run_server.py
