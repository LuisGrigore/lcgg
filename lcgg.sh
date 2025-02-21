#!/bin/bash

NAME="lcgg"

# Internal command variables
LCGG_DIR="/usr/local/bin/${NAME}_tool"
APP_DIR="$LCGG_DIR/app"

# Project command variables
BASE_DIR="$(pwd)"
SRC_DIR="$BASE_DIR/src"
TEST_DIR="$BASE_DIR/test"
EXTERNALS_DIR="$BASE_DIR/externals"
TARGET_DIR="$BASE_DIR/target"
INCLUDES_DIR="$BASE_DIR/includes"

# Error messages
E_COMMAND_NOT_FOUND="❌ Error: Command not found."
E_NOT_IN_ROOT_DIR="❌ Error: lcgg should be run in the root directory of the project."

# Informational messages
MSG_BUILDING="🛠️ Building project..."
MSG_TESTING="🧪 Running tests..."
MSG_UNINSTALLING="🗑️ Uninstalling lcgg..."
MSG_STRUCTURE_UPDATING="📂 Updating project structure..."
MSG_DONE="✅ Done!"

# Helper functions
copy_dir_structure() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: $0 <source_directory> <destination_directory>"
        exit 1
    fi

    local DIR_ORIGEN="$1"
    local DIR_DESTINO="$2"

    copy_structure_recursive() {
        local current_dir="$1"
        local dest_dir="$2"

        mkdir -p "$dest_dir"

        for item in "$current_dir"/*; do
            if [ -d "$item" ]; then
                copy_structure_recursive "$item" "$dest_dir/$(basename "$item")"
            fi
        done
    }

    copy_structure_recursive "$DIR_ORIGEN" "$DIR_DESTINO"
    echo "📁 Directory structure copied from '$DIR_ORIGEN' to '$DIR_DESTINO'."
}

check_dir() {
    if [ ! -f ".lcgg_root" ]; then
        echo "$E_NOT_IN_ROOT_DIR"
        exit 1
    fi
}

show_help() {
    echo "📖 Usage: lcgg -[COMMAND]"
    echo ""
    echo "Available commands:"
    echo "  -build                Builds the project (.o and executables)."
    echo "  -init                 Initializes the current directory as an lcgg project."
    echo "  -update-structure     Updates all directories that should mirror 'src'."
    echo "  -test                 Compiles and runs tests in the 'test' folder."
    echo "  -uninstall            Updates lcgg tool to the latest version."
    echo "  -uninstall            Uninstalls lcgg tool."
    echo "  -help                 Displays this help message."
}

init() {
    echo "🚀 Initializing lcgg project..."
    mkdir -p "$SRC_DIR"
    mkdir -p "$EXTERNALS_DIR"
    mkdir -p "$TEST_DIR"
    mkdir -p "$INCLUDES_DIR"
    echo "Project name" > .lcgg_root
    echo "$MSG_DONE"
}

build() {
    echo "$MSG_BUILDING"
    make -f "$APP_DIR/build_make" SRC_DIR="$SRC_DIR" EXTERNALS_DIR="$EXTERNALS_DIR" OBJ_DIR="$TARGET_DIR/build"
    echo "$MSG_DONE"
}

update_structure() {
    echo "$MSG_STRUCTURE_UPDATING"
    copy_dir_structure "$SRC_DIR" "$TEST_DIR"
    copy_dir_structure "$SRC_DIR" "$INCLUDES_DIR"
    copy_dir_structure "$SRC_DIR" "$TARGET_DIR/build"
    echo "$MSG_DONE"
}

build_command() {
    echo "$MSG_BUILDING"
    check_dir
    update_structure
    build
}

test_command() {
    echo "$MSG_TESTING"
    build_command
    echo "$MSG_DONE"
}

uninstall() {
    echo "$MSG_UNINSTALLING"
    sudo rm -f /usr/local/bin/lcgg
    sudo rm -rf /usr/local/bin/lcgg_tool
    echo "$MSG_DONE"
}

args_check() {
    if [ $# -eq 0 ]; then
        echo "$E_COMMAND_NOT_FOUND"
        show_help
        exit 1
    fi
}

update_command()
{
	curl -sSL https://raw.githubusercontent.com/LuisGrigore/lcgg/main/install.sh | bash
}

# Entry point
args_check "$@"

case "$1" in
    -help)
        show_help
        ;;
    -init)
        init
        ;;
    -update-structure)
        update_structure
        ;;
    -build)
        build_command
        ;;
    -test)
        test_command
        ;;
	-update)
        update_command
        ;;
    -uninstall)
        uninstall
        ;;
    *)
        echo "❌ Error: Unknown command '$1'. Use -help to see available commands."
        exit 1
        ;;
esac
