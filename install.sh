INSTALL_DIR="/usr/local/bin/lcgg"
BIN_PATH="/usr/local/bin/lcgg"

echo "Instalando mi herramienta en $INSTALL_DIR..."

# Crear directorio y copiar archivos
sudo mkdir -p "$INSTALL_DIR"
sudo cp -r ./* "$INSTALL_DIR"

# Crear un enlace simbólico en /usr/local/bin para facilitar la ejecución
sudo ln -sf "$INSTALL_DIR/mi-herramienta.sh" "$BIN_PATH"

# Dar permisos de ejecución
sudo chmod +x "$BIN_PATH"

echo "Instalación completada. Ahora puedes ejecutar 'mi-herramienta.sh' desde cualquier lugar."