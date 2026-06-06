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

# --- 3. Font Installation ---
install_font() {
    if [ "$(uname)" = "Darwin" ]; then
        # Check if already installed in system or user font directories first
        if [ -f "$HOME/Library/Fonts/JetBrainsMonoNerdFontMono-Regular.ttf" ] || [ -f "/Library/Fonts/JetBrainsMonoNerdFontMono-Regular.ttf" ]; then
            echo "JetBrains Mono Nerd Font is already installed."
            return 0
        fi

        # If Homebrew is installed, use it to install the font
        if command -v brew >/dev/null 2>&1; then
            echo "Installing JetBrains Mono Nerd Font via Homebrew Cask..."
            # Check if font is already installed via brew to avoid redundancy
            if ! brew list --cask font-jetbrains-mono-nerd-font >/dev/null 2>&1; then
                brew install --cask font-jetbrains-mono-nerd-font
                echo "JetBrains Mono Nerd Font installed successfully via Homebrew!"
                return 0
            fi
        fi

        # Fallback to manual download if Homebrew is not present or installation failed
        echo "Homebrew not found or not used. Downloading JetBrains Mono Nerd Font manually..."
        local font_dir="$HOME/Library/Fonts"
        mkdir -p "$font_dir"
        local tmp_zip="/tmp/JetBrainsMono.zip"
        curl -fLo "$tmp_zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"
        unzip -o "$tmp_zip" "*.ttf" -d "$font_dir"
        rm -f "$tmp_zip"
        echo "JetBrains Mono Nerd Font installed manually to ~/Library/Fonts!"
    else
        # Linux installation (XDG directory standard)
        local font_dir="$HOME/.local/share/fonts"
        if [ ! -f "$font_dir/JetBrainsMonoNerdFontMono-Regular.ttf" ] && [ ! -f "$font_dir/JetBrainsMonoNerdFont-Regular.ttf" ]; then
            echo "Installing JetBrains Mono Nerd Font on Linux..."
            mkdir -p "$font_dir"
            local tmp_zip="/tmp/JetBrainsMono.zip"
            curl -fLo "$tmp_zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"
            unzip -o "$tmp_zip" "*.ttf" -d "$font_dir"
            rm -f "$tmp_zip"
            if command -v fc-cache >/dev/null 2>&1; then
                echo "Rebuilding font cache..."
                fc-cache -f
            fi
            echo "JetBrains Mono Nerd Font installed successfully!"
        else
            echo "JetBrains Mono Nerd Font is already installed."
        fi
    fi
}

install_font

echo "Bootstrap finished! Please restart your terminal or run 'source ~/.zshrc'."
