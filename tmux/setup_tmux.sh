#!/bin/bash
set -e

# NOTE: must be $HOME, not "~" - tilde does not expand inside quotes.
# (An earlier version of this script cloned TPM into a literal ./~ directory.)
TPM_DIR="$HOME/.tmux/plugins/tpm"
TMUX_CONF="$HOME/.config/tmux/tmux.conf"

echo "🚀 Starting TMUX Plugin Manager (TPM) setup..."

# 1. Clone TPM if it doesn't exist
if [ ! -d "$TPM_DIR" ]; then
  echo "📁 cloning TPM into $TPM_DIR..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "✅ TPM is already installed at $TPM_DIR"
fi

# 2. Ensure tmux.conf contains TPM initialization.
# Match on the stable path suffix: the conf refers to tpm via "~/", which
# would never equal the expanded $TPM_DIR string.
if ! grep -q "plugins/tpm/tpm'" "$TMUX_CONF"; then
  echo "⚙️  Adding TPM initialization to $TMUX_CONF..."
  printf "\n# Initialize TPM\nrun '%s/tpm'\n" "$TPM_DIR" >> "$TMUX_CONF"
else
  echo "✅ TPM is already initialized in $TMUX_CONF"
fi

# 3. Reload the tmux configuration (only if a server is running)
if tmux info &> /dev/null; then
  echo "🔄 Reloading tmux configuration..."
  tmux source-file "$TMUX_CONF"
fi

# 4. Install plugins using TPM
echo "📦 Installing tmux plugins..."
"$TPM_DIR/bin/install_plugins"

echo "🎉 TMUX Plugin Manager setup complete!"
