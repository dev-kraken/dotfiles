#!/bin/bash

# ========================
# Tmux Plugin Installer
# Dev-Kraken's Configuration
# ========================

set -e

TMUX_CONFIG_DIR="$HOME/.config/tmux"
PLUGIN_DIR="$TMUX_CONFIG_DIR/.tmux/plugins"

echo "🚀 Installing Tmux plugins for Dev-Kraken's configuration..."

# Ensure directories exist
echo "📁 Creating necessary directories..."
mkdir -p "$PLUGIN_DIR"

# Install TPM (Tmux Plugin Manager) if not already installed
if [ ! -d "$PLUGIN_DIR/tpm" ]; then
    echo "📦 Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$PLUGIN_DIR/tpm"
else
    echo "✅ TPM already installed"
fi

# Check if tmux is running
if pgrep -x "tmux" > /dev/null; then
    echo "🔄 Tmux is running. Reloading configuration..."
    tmux source-file "$TMUX_CONFIG_DIR/tmux.conf"
    
    echo "📦 Installing plugins via TPM..."
    "$PLUGIN_DIR/tpm/scripts/install_plugins.sh"
    
    echo "🔄 Updating existing plugins..."
    "$PLUGIN_DIR/tpm/scripts/update_plugin.sh"
else
    echo "⚠️  Tmux is not running. Starting a detached session to install plugins..."
    tmux new-session -d -s plugin_install
    tmux send-keys -t plugin_install "~/.config/tmux/.tmux/plugins/tpm/scripts/install_plugins.sh" Enter
    sleep 5
    tmux kill-session -t plugin_install
fi

# Verify installations
echo "🔍 Verifying plugin installations..."

plugins=(
    "tpm"
    "tmux-sensible" 
    "vim-tmux-navigator"
    "catppuccin"
    "tmux-resurrect"
    "tmux-continuum"
    "tmux-fzf"
    "tmux-sessionx"
    "tmux-yank"
    "tmux-online-status"
    "tmux-battery"
)

missing_plugins=()

for plugin in "${plugins[@]}"; do
    if [ -d "$PLUGIN_DIR"/*"$plugin"* ] 2>/dev/null; then
        echo "✅ $plugin installed"
    else
        echo "❌ $plugin missing"
        missing_plugins+=("$plugin")
    fi
done

if [ ${#missing_plugins[@]} -eq 0 ]; then
    echo "🎉 All plugins successfully installed!"
else
    echo "⚠️  Missing plugins: ${missing_plugins[*]}"
    echo "💡 Try running: tmux new-session -d && tmux send-keys 'prefix + I' && tmux kill-session"
fi

echo ""
echo "📋 Next steps:"
echo "1. Start tmux: tmux"
echo "2. If plugins aren't loaded, press: Ctrl+Space + I (to install)"
echo "3. Press: Ctrl+Space + U (to update plugins)"
echo "4. Restart tmux or press: Ctrl+Space + r (to reload config)"
echo ""
echo "🎨 Your tmux now matches your Neovim Catppuccin theme!"
echo "🚀 Enjoy seamless navigation between tmux panes and Neovim splits!" 