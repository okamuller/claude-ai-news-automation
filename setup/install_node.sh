#!/usr/bin/env bash
set -euo pipefail

required_major=20

needs_install=true
if command -v node >/dev/null 2>&1; then
  current_version="$(node -v)"
  current_major="$(printf '%s' "$current_version" | sed -E 's/^v([0-9]+).*/\1/')"

  if [[ "$current_major" =~ ^[0-9]+$ ]] && [ "$current_major" -ge "$required_major" ]; then
    echo "Node.js is already installed and supported: $current_version"
    needs_install=false
  else
    echo "Detected unsupported Node.js version: $current_version"
    echo "Upgrading to Node.js ${required_major}.x..."
  fi
fi

if [ "$needs_install" = true ]; then
  if command -v apt-get >/dev/null 2>&1; then
    echo "Installing Node.js ${required_major}.x via NodeSource..."
    curl -fsSL https://deb.nodesource.com/setup_${required_major}.x | sudo -E bash -
    sudo apt-get install -y nodejs
  else
    echo "apt-get was not found. Please install Node.js ${required_major}+ manually."
    exit 1
  fi
fi

echo "Installed Node.js: $(node -v)"
echo "Installed npm: $(npm -v)"
