#!/bin/bash
# Script to install tools and dependencies.

set -e

echo "Starting dotfiles bootstrap..."

# Ensure Zsh is installed
if ! command -v zsh >/dev/null 2>&1; then
    echo "Error: Zsh is not installed. Please install Zsh first."
    exit 1
fi

# --- 1. Linking ---
# Run the linker script first
sh ./install.sh

# --- 2. Tool Installation ---
USER_BIN_DIR="$HOME/.local/bin"
mkdir -p "$USER_BIN_DIR"

# Ensure Vim directories exist
mkdir -p "$HOME/.vim/undodir"

# Install Starship
if ! command -v starship >/dev/null 2>&1; then
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir "$USER_BIN_DIR"
fi

# Install Zsh Plugins (Oh My Zsh)
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
install_zsh_plugin() {
    local name="$1"
    local url="$2"
    if [ ! -d "$ZSH_CUSTOM/plugins/$name" ]; then
        echo "Installing $name..."
        git clone --depth 1 "$url" "$ZSH_CUSTOM/plugins/$name"
    fi
}

install_zsh_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
install_zsh_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"
install_zsh_plugin "zsh-completions" "https://github.com/zsh-users/zsh-completions"

echo "Bootstrap finished! Please restart your terminal or run 'source ~/.zshrc'."
