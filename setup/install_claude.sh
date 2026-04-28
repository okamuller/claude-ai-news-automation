#!/usr/bin/env bash
set -euo pipefail

if ! command -v npm >/dev/null 2>&1; then
  echo "npm is required. Run setup/install_node.sh first."
  exit 1
fi

echo "Installing Claude Code CLI globally..."
sudo npm install -g @anthropic-ai/claude-code

echo "Claude CLI path: $(command -v claude || true)"
claude --version || true

echo "Next step: run 'claude login' to authenticate."
