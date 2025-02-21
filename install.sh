#!/bin/bash

set -e  # Detiene el script en caso de error

# Definir variables
REPO_URL="https://github.com/LuisGrigore/lcgg.git"
INSTALL_DIR="/usr/local/bin"
APP_DIR="app"
BIN_NAME="lcgg"

echo "Instalando $BIN_NAME..."

# Descargar el último código desde GitHub
if [ -d "$BIN_NAME" ]; then
    rm -rf "$BIN_NAME"
fi

git clone "$REPO_URL" "$BIN_NAME"
cd "lcgg/app"

# Copiar el ejecutable al directorio de binarios del sistema
chmod +x "$BIN_NAME"
sudo mv "$BIN_NAME" "$INSTALL_DIR/"

echo "Instalación completada. Ahora puedes ejecutar '$BIN_NAME' desde cualquier lugar."
