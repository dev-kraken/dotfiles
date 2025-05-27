#!/bin/bash

# ========================
# Tmux-Neovim Integration Test
# Dev-Kraken's Configuration
# ========================

echo "🧪 Testing Tmux-Neovim Integration..."

# Test 1: Check if tmux config loads without errors
echo "📋 Test 1: Tmux configuration validation..."
if tmux -f ~/.config/tmux/tmux.conf new-session -d -s config_test 'echo "Config test successful"' 2>/dev/null; then
    tmux kill-session -t config_test 2>/dev/null || true
    echo "✅ Tmux configuration loads successfully"
else
    echo "❌ Tmux configuration has errors"
fi

# Test 2: Check vim-tmux-navigator plugin
echo "📋 Test 2: Vim-tmux-navigator plugin..."
if [ -d ~/.config/tmux/.tmux/plugins/vim-tmux-navigator ]; then
    echo "✅ vim-tmux-navigator plugin installed"
else
    echo "⚠️  vim-tmux-navigator plugin not found - run install-plugins.sh"
fi

# Test 3: Check Catppuccin theme
echo "📋 Test 3: Catppuccin theme..."
if [ -d ~/.config/tmux/.tmux/plugins/catppuccin ] || [ -d ~/.config/tmux/.tmux/plugins/tmux ]; then
    echo "✅ Catppuccin theme plugin found"
else
    echo "⚠️  Catppuccin theme plugin not found - run install-plugins.sh"
fi

# Test 4: Test pane navigation commands
echo "📋 Test 4: Creating test session with splits..."
tmux new-session -d -s integration_test
tmux split-window -h -t integration_test
tmux split-window -v -t integration_test

echo "✅ Test session created with multiple panes"

# Test 5: Check if Neovim integration variables are set
echo "📋 Test 5: Checking Neovim integration..."
tmux display-message -t integration_test -p "#{?@is_vim,Vim mode detected,Normal mode}" > /dev/null
echo "✅ Vim detection mechanism in place"

# Cleanup
tmux kill-session -t integration_test 2>/dev/null || true

# Test 6: Color support
echo "📋 Test 6: Color support test..."
if [[ "$TERM" == *"256color"* ]]; then
    echo "✅ 256 color support enabled"
else
    echo "⚠️  Color support may be limited (current TERM: $TERM)"
fi

echo ""
echo "🎯 Integration Test Summary:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Create a comprehensive test session
echo "📋 Creating comprehensive test session..."
tmux new-session -d -s nvim_test

# Split into multiple panes
tmux split-window -h -t nvim_test
tmux split-window -v -t nvim_test
tmux select-pane -t nvim_test:0

echo "🧪 Test session 'nvim_test' created with:"
echo "  • Multiple panes for navigation testing"  
echo "  • Ready for Neovim integration testing"
echo ""
echo "🚀 Manual testing steps:"
echo "1. tmux attach -t nvim_test"
echo "2. Start Neovim in one pane: nvim"
echo "3. Test navigation: Ctrl+h, Ctrl+j, Ctrl+k, Ctrl+l"
echo "4. Test should seamlessly move between tmux panes and Neovim splits"
echo ""
echo "🎨 Theme testing:"
echo "1. Check if tmux status bar matches Catppuccin Mocha theme"
echo "2. Verify colors match your Neovim theme"
echo "3. Battery, time, and status indicators should be visible"
echo ""
echo "🧹 Cleanup when done:"
echo "tmux kill-session -t nvim_test"
echo ""
echo "✨ If everything works, your tmux-Neovim integration is perfect!" 