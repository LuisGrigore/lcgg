NAME="lcgg"

#var for internal commands

export LCGG_DIR="/usr/local/bin/${NAME}_tool"

export APP_DIR=$LCGG_DIR/app


#vars for project commands
export BASE_DIR="$(pwd)"

export SRC_DIR=$BASE_DIR/src

export TEST_DIR=$BASE_DIR/test

export EXTERNALS_DIR=$BASE_DIR/externals

export TARGET_DIR=$BASE_DIR/target

export INCLUDES_DIR=$BASE_DIR/includes

chek_dir()
{
	if [ ! -f ".lcgg_root" ]; then
    	echo "lcgg should be run in the root directory of the project."
		exit 1
	fi
}

show_help() {
    echo "Uso: ./lcgg -[COMANDO]"
    echo ""
    echo "Comandos disponibles:"
    echo "	-build						Compila el proyecto usando Makefile"
	echo "	-init						Copia la estructura de carpetas de src a test sin alterar lo ya existente"
	echo "	-update-structure			Copia la estructura de carpetas de src a test sin alterar lo ya existente"
    echo "	-test						Ejecuta pruebas definidas en Makefile"
    echo "	-uninstall					Uninstalls lcgg tool."
    echo "	-help						Muestra este mensaje de ayuda"
}

copy_dir_structure() {
	if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <directorio_origen> <directorio_destino>"
    exit 1
	fi

	DIR_ORIGEN="$1"
	DIR_DESTINO="$2"

	copiar_estructura() {
	    local dir_actual="$1"
	    local dir_dest="$2"

	    mkdir -p "$dir_dest"

	    for item in "$dir_actual"/*; do
	        if [ -d "$item" ]; then
	            copiar_estructura "$item" "$dir_dest/$(basename "$item")"
	        fi
	    done
	}

	copiar_estructura "$DIR_ORIGEN" "$DIR_DESTINO"
	echo "La estructura de directorios se ha copiado de '$DIR_ORIGEN' a '$DIR_DESTINO'."
}

init()
{
	mkdir -p $SRC_DIR
	mkdir -p $EXTERNALS_DIR
	mkdir -p $TEST_DIR
	mkdir -p $INCLUDES_DIR
	echo "Project name" > .lcgg_root
}

build(){
	echo "🧪 Compilando ..."
    SRC_DIR=$SRC_DIR EXTERNALS_DIR=$EXTERNALS_DIR OBJ_DIR=$TARGET_DIR/build make -f $APP_DIR/build_make
}

update_structure()
{
	echo "Updating..."
	copy_dir_structure "$SRC_DIR" "$TEST_DIR"
	copy_dir_structure "$SRC_DIR" "$INCLUDES_DIR"
	copy_dir_structure "$SRC_DIR" "$TARGET_DIR/build"
}

update_structure_command()
{
	update_project_structure
}


build_command()
{
	chek_dir
	update_project_structure_command
	build
}

test_command()
{
	build_command

}
uninstall()
{
	sudo rm -f /usr/local/bin/lcgg
	sudo rm -rf /usr/local/bin/lcgg_tool
}


# Verifica si se pasó un argumento
if [ $# -eq 0 ]; then
    echo "Error: No se proporcionó ningún comando. Usa -help para más información."
    exit 1
fi
# Procesa el argumento
case "$1" in
    -help)
        show_help
        ;;
    -init)
	    init
	    ;;
	-update-structure)
		update_project_command
		;;
    -build)
        build_command
        ;;
    -test)
		test_command
        ;;
	-uninstall)
		uninstall
		;;
    *)
        echo "Error: Comando no reconocido '$1'. Usa -help para ver los comandos disponibles."
        exit 1
        ;;
esac
