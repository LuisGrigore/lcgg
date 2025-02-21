NAME="lcgg"

INSTALL_DIR="/usr/local/bin/$($NAME)_tool"
BIN_PATH="/usr/local/bin"

echo "Instalando mi herramienta en $INSTALL_DIR..."

# Crear directorio y copiar archivos
sudo mkdir -p "$INSTALL_DIR"
sudo git clone https://github.com/LuisGrigore/lcgg.git $INSTALL_DIR
#sudo cp -r ./lcgg "$INSTALL_DIR"

# Crear un enlace simbólico en /usr/local/bin para facilitar la ejecución
sudo ln -sf "$INSTALL_DIR/$($NAME).sh" "$BIN_PATH/$($NAME)"

# Dar permisos de ejecución
sudo chmod +x "$INSTALL_DIR"

echo "Instalation compleated. Now you can use '$($NAME)'."