#!/bin/bash

TPM_DIR="~/.tmux/plugins/tpm"

echo "🚀 Starting TMUX Plugin Manager (TPM) setup..."

# 1. Clone TPM if it doesn't exist
if [ ! -d "$TPM_DIR" ]; then
  echo "📁 cloning TPM into $TPM_DIR..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "✅ TPM is already installed at $TPM_DIR"
fi

# 2. Ensure .tmux.conf contains TPM initialization
TMUX_CONF="$HOME/.config/tmux/.tmux.conf"

if ! grep -q "run '$TPM_DIR/tpm'" "$TMUX_CONF"; then
  echo "⚙️  Adding TPM initialization to $TMUX_CONF..."
  echo -e "\n# Initialize TPM\nrun '$TPM_DIR/tpm'" >> "$TMUX_CONF"
else
  echo "✅ TPM is already initialized in $TMUX_CONF"
fi

# 3. Source the tmux configuration
echo "🔄 Reloading tmux configuration..."
tmux source-file "$TMUX_CONF"
tmux source "$TMUX_CONF" # just to be safe? redundant?

# 4. Install plugins using TPM
echo "📦 Installing tmux plugins..."
"$TPM_DIR/bin/install_plugins"

echo "🎉 TMUX Plugin Manager setup complete!"
