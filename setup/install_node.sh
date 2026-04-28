#!/usr/bin/env bash
set -euo pipefail

if command -v node >/dev/null 2>&1; then
  echo "Node.js is already installed: $(node -v)"
  exit 0
fi

if command -v apt-get >/dev/null 2>&1; then
  echo "Installing Node.js 20.x via NodeSource..."
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt-get install -y nodejs
else
  echo "apt-get was not found. Please install Node.js 20+ manually."
  exit 1
fi

echo "Installed Node.js: $(node -v)"
echo "Installed npm: $(npm -v)"
