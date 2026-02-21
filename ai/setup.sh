#!/bin/bash
# AI tools setup script

set -e

echo "=== AI Tools Setup ==="

# Install Claude Code (standalone binary)
if ! command -v claude &>/dev/null; then
  echo "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
else
  echo "Claude Code already installed ($(claude --version 2>/dev/null))"
fi

echo ""
echo "=== AI Tools Setup Complete ==="
echo "Note: Run 'claude' to login on first use"
