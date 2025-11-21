#!/bin/bash
set -e

echo "------ Starting Deployment on VM ------"

APP_DIR="/home/deployuser01/app"
SERVICE="kxn-backend-new01.service"

echo "Moving to app directory: $APP_DIR"
cd $APP_DIR

# Ensure venv exists
if [ ! -d "venv" ]; then
  echo "Creating Python virtual environment..."
  python3 -m venv venv
fi

echo "Activating virtual environment..."
source venv/bin/activate

echo "Upgrading pip..."
pip install --upgrade pip

# Install dependencies
if [ -f requirements.txt ]; then
  echo "Installing dependencies from requirements.txt"
  pip install -r requirements.txt
else
  echo "requirements.txt not found!"
fi

echo "Restarting systemd service: $SERVICE"
sudo systemctl restart $SERVICE
sudo systemctl status $SERVICE --no-pager || true

echo "------ Deployment Completed Successfully ------"
