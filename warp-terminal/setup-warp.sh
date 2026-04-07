#!/usr/bin/env bash
# Setup script for OS-specific Warp Terminal keybindings

set -e

DOTFILES_DIR="$HOME/.dotfiles/warp-terminal/.config/warp-terminal"
TARGET_DIR="$HOME/.config/warp-terminal"
TARGET_FILE="$TARGET_DIR/keybindings.yaml"

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

echo "Detected OS: $OS"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Remove existing keybindings.yaml if it exists
if [[ -e "$TARGET_FILE" ]]; then
    echo "Removing existing keybindings.yaml..."
    rm "$TARGET_FILE"
fi

# Create symlink to OS-specific keybindings
SOURCE_FILE="$DOTFILES_DIR/keybindings-$OS.yaml"
if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "Error: $SOURCE_FILE not found"
    exit 1
fi

echo "Linking $SOURCE_FILE -> $TARGET_FILE"
ln -s "$SOURCE_FILE" "$TARGET_FILE"

echo "✓ Warp Terminal keybindings configured for $OS"
