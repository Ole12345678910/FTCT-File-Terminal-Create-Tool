#!/bin/bash

#Sett script-path
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

welcome_function() {
    clear
    ascii_logo=$(cat <<'EOF'
 /$$$$$$$$ /$$$$$$$$ /$$$$$$  /$$$$$$$$
| $$_____/|__  $$__//$$__  $$|__  $$__/
| $$         | $$  | $$  \__/   | $$   
| $$$$$      | $$  | $$         | $$   
| $$__/      | $$  | $$         | $$   
| $$         | $$  | $$    $$   | $$   
| $$         | $$  |  $$$$$$/   | $$   
|__/         |__/   \______/    |__/  
EOF
)

    # Logo animation
    clear
    while IFS= read -r line; do
        echo -e "\e[32m$line\e[0m"
        sleep 0.05
    done <<< "$ascii_logo"

    echo
    echo -e "\e[32mWelcome to FTCT - File Terminal Create Tool!\e[0m"
    sleep 1.5


    # Welcome message in dialog
    dialog --title "FTCT" --msgbox "Welcome to File Terminal Create Tool!\n\nUse this interface to create, update, and manage your files with ease." 12 60
    
}

# Main menu loop
main_menu() {
    while true; do
        CHOICE=$(dialog --title "Main Menu" --menu "Select:" 15 50 4 \
        1 "Create Files" \
        2 "Update Files" \
        3 "Exit" \
        3>&1 1>&2 2>&3)

        case $CHOICE in
            1) "$SCRIPT_DIR/createFiles.sh" ;;
            2) "$SCRIPT_DIR/updateFiles.sh" ;;
            3) clear; exit 0 ;;
        esac
    done
}
welcome_function
main_menu