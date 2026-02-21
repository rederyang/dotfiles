#!/bin/bash
# AI tools setup script

set -e

echo "=== AI Tools Setup ==="

# Install nvm
if [ ! -d "$HOME/.nvm" ]; then
  echo "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  # nvm loading code will be auto-injected into ~/.zshrc
fi

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# Install Node.js LTS
if ! nvm ls --no-colors | grep -q "lts"; then
  echo "Installing Node.js LTS..."
  nvm install --lts
fi

nvm use --lts

# Install AI CLI tools
echo "Installing AI CLI tools..."
npm install -g @anthropic-ai/claude-code
npm install -g @openai/codex
npm install -g @google/gemini-cli

echo ""
echo "=== AI Tools Setup Complete ==="
echo "Note: Each tool requires authentication on first run:"
echo "  claude       → OAuth login"
echo "  codex        → OAuth login"
echo "  gemini       → OAuth login"
