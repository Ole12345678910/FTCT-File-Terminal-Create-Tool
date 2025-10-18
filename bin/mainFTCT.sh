#!/bin/bash

# Find scripts in onw path
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Makes the scripts runable
chmod +x "$SCRIPT_DIR/createFiles.sh" "$SCRIPT_DIR/updateFiles.sh" "$SCRIPT_DIR/mainFTCT.sh"

echo -e '\e[32m
    ________________________
   / ____/_  __/ ____/_  __/
  / /_    / / / /     / /   
 / __/   / / / /___  / /    
/_/     /_/  \____/ /_/     
                            \e[0m'
echo -e "Welcome to FTCT File Terminal Create Tool!"
echo
echo -e "\e[32m1) Make files\e[0m"
echo -e "\e[33m2) Update Files\e[0m"
echo -e "\e[31m3) Quit\e[0m"
echo

read -p "Pick a number: " choice

case $choice in
    1)
        "$SCRIPT_DIR/createFiles.sh"
        ;;
    2)
        "$SCRIPT_DIR/updateFiles.sh"
        ;;
    3)
        echo -e "\e[31mStopped...\e[0m"
        exit 0
        ;;
    *)
        echo -e "\e[31mIncorrect choice!\e[0m"
        ;;
esac
