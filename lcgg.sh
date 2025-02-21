NAME="lcgg"

#var for internal commands
LCGG_DIR="/usr/local/bin/${NAME}_tool"
APP_DIR=$LCGG_DIR/app

#vars for project commands
BASE_DIR="$(pwd)"
SRC_DIR=$BASE_DIR/src
TEST_DIR=$BASE_DIR/test
EXTERNALS_DIR=$BASE_DIR/externals
TARGET_DIR=$BASE_DIR/target
INCLUDES_DIR=$BASE_DIR/includes

#ErrorMessages
E_COMMAND_NOT_FOUND="Command not found."
E_NOT_IN_ROOT_DIR="lcgg should be run in the root directory of the project."

#Helper functions


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

chek_dir()
{
	if [ ! -f ".lcgg_root" ]; then
    	echo $E_NOT_IN_ROOT_DIR
		exit 1
	fi
}

show_help() {
    echo "Usage: lcgg -[COMMAND]"
    echo ""
    echo "Availible commands:"
    echo "	-build						Builds the .o and executables from src to target/build and target/out respectively."
	echo "	-init						Makes current directory into a lcgg project."
	echo "	-update-structure			Updates all directories that should mimic src."
    echo "	-test						Compiles and runs tests inside test folder."
    echo "	-uninstall					Uninstalls lcgg tool."
    echo "	-help						Shows help"
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
    SRC_DIR=$SRC_DIR EXTERNALS_DIR=$EXTERNALS_DIR OBJ_DIR=$TARGET_DIR/build make -f $APP_DIR/build_make
}

update_structure()
{
	copy_dir_structure "$SRC_DIR" "$TEST_DIR"
	copy_dir_structure "$SRC_DIR" "$INCLUDES_DIR"
	copy_dir_structure "$SRC_DIR" "$TARGET_DIR/build"
}

update_structure_command()
{
	echo "UPDATING STRUCTURE ..."
	update_project_structure
}


build_command()
{
	echo "🧪 BUILDING ..."
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

uninstall_command()
{
	echo "UNINSTALLING ..."
	uninstall
}

args_check()
{
	if [ $1 -eq 0 ]; then
	    echo $E_COMMAND_NOT_FOUND
		show_help
	    exit 1
	fi
}
# Entry point

args_check $#

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
