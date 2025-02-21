#!/bin/bash
NAME="lcgg"


INSTALL_DIR="/usr/local/bin"


echo "Instalando mi herramienta en $INSTALL_DIR..."

# Crear directorio y copiar archivos
#sudo mkdir -p "$INSTALL_DIR"
sudo cp -r ./$NAME "$INSTALL_DIR"
sudo rm -rf ./$NAME

# Crear un enlace simbólico en /usr/local/bin para facilitar la ejecución
sudo ln -sf "$INSTALL_DIR/$NAME/$NAME" "$BIN_PATH"

# Dar permisos de ejecución
sudo chmod +x "$BIN_PATH"

echo "Instalación completada. Ahora puedes ejecutar '$NAME' desde cualquier lugar."
