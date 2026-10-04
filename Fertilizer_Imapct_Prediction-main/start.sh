#!/bin/bash
set -e
cd "$(dirname "$0")"

if [ -x "./venv/bin/python" ] && ! ./venv/bin/python --version >/dev/null 2>&1; then
  echo "Existing virtual environment is invalid; recreating it..."
  rm -rf ./venv
fi

if [ ! -x "./venv/bin/python" ]; then
  echo "Creating virtual environment..."
  python3 -m venv venv
fi

source ./venv/bin/activate
python -m pip install -r requirements-server.txt

echo "Starting AgriNexus server..."
python run_server.py
