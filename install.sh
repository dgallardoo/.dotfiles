#!/bin/sh
# Script to link configuration files from the repository to the home directory.

set -e

DOTFILES_ROOT_DIR=$(pwd)

# Helper to create symlinks, ensuring parent directories exist
link_file() {
    local src="$1"
    local dst="$2"
    
    mkdir -p "$(dirname "$dst")"
    echo "Linking $dst -> $src"
    ln -sf "$src" "$dst"
}

echo "Starting dotfiles linking..."

# --- Configuration Mappings ---

# Core Git
link_file "$DOTFILES_ROOT_DIR/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_ROOT_DIR/.gitignore" "$HOME/.gitignore"

# Shell (Zsh)
link_file "$DOTFILES_ROOT_DIR/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_ROOT_DIR/.zprofile" "$HOME/.zprofile"

# Starship & Terminal (Ghostty)
link_file "$DOTFILES_ROOT_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
link_file "$DOTFILES_ROOT_DIR/.config/ghostty/config" "$HOME/.config/ghostty/config"

# Editors & Multiplexers
link_file "$DOTFILES_ROOT_DIR/.vimrc" "$HOME/.vimrc"
link_file "$DOTFILES_ROOT_DIR/.tmux.conf" "$HOME/.tmux.conf"

echo "Linking finished!"
