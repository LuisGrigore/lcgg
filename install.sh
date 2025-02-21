#!/bin/bash

NAME="lcgg"
INSTALL_DIR="/usr/local/bin/${NAME}_tool"
BIN_PATH="/usr/local/bin"

echo "🔍 Checking installation in $INSTALL_DIR..."

# If the tool is already installed, update it
if [ -d "$INSTALL_DIR/.git" ]; then
    echo "🔄 Updating the tool..."
    sudo git -C "$INSTALL_DIR" pull
else
    echo "📥 Installing the tool..."
    sudo mkdir -p "$INSTALL_DIR"
    sudo git clone https://github.com/LuisGrigore/lcgg.git "$INSTALL_DIR"
fi

# Create a symbolic link in /usr/local/bin for easy execution
sudo ln -sf "$INSTALL_DIR/${NAME}.sh" "$BIN_PATH/${NAME}"

# Ensure the main script has execution permissions
sudo chmod +x "$INSTALL_DIR/${NAME}.sh"

echo
echo "--------------- Installation / Update Completed ----------------"
echo
echo "Now you can use '${NAME}' in the terminal."
