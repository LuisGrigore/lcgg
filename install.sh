#!/bin/bash
NAME="lcgg"


INSTALL_DIR="/usr/local/bin/$NAME"
BIN_PATH="/usr/local/bin/$NAME"

echo "Instalando mi herramienta en $INSTALL_DIR..."

# Crear directorio y copiar archivos
sudo mkdir -p "$INSTALL_DIR"
sudo cp -r ./* "$INSTALL_DIR"

# Crear un enlace simbólico en /usr/local/bin para facilitar la ejecución
sudo ln -sf "$INSTALL_DIR/$NAME" "$BIN_PATH"

# Dar permisos de ejecución
sudo chmod +x "$BIN_PATH"

echo "Instalación completada. Ahora puedes ejecutar '$NAME' desde cualquier lugar."
