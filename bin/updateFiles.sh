#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Loop for updating files
while true; do
    # Ask user for the folder path
    pathSelect=$(dialog --clear --title 'Path' --inputbox 'Select which path you want to update:' 10 50 3>&1 1>&2 2>&3)
    [ $? -ne 0 ] && exit 0  # Exit if user presses ESC or Cancel

    

    # Check if the folder exists
    if [[ ! -d "$pathSelect" ]]; then
        dialog --title 'Error' --msgbox 'Folder does not exist!' 10 50
        continue
    fi

    # Ask user for the file to edit
    fileEdit=$(dialog --clear --title 'File' --inputbox 'Select which file you want to edit:' 10 50 3>&1 1>&2 2>&3)
    [ $? -ne 0 ] && exit 0

    # Check if the file exists
    if [[ ! -f "$pathSelect/$fileEdit" ]]; then
        dialog --title 'Error' --msgbox 'File does not exist!' 10 50
        continue
    fi

    # Ask user whether to update or add to the file
    decide=$(dialog --clear --title 'Decide' --menu 'Choose an option:' 10 50 2 \
    U "Update file" \
    A "Add to file" 3>&1 1>&2 2>&3)

    case $decide in
        U)
            # Get new content to overwrite the file
            fileAction=$(dialog --title 'Update' --inputbox 'Enter new content for the file:' 10 50 3>&1 1>&2 2>&3)
            echo "$fileAction" > "$pathSelect/$fileEdit"
            {
            for i in $(seq 0 5 100); do
                sleep 0.1  # simulate work
                echo $i
            done
            } | dialog --title "Updating" --gauge "Please wait..." 10 50 0
            dialog --title 'Done' --msgbox 'File updated successfully!' 10 50
            ;;
        A)
            # Get content to append to the file
            fileAction=$(dialog --title 'Add' --inputbox 'Enter content to append:' 10 50 3>&1 1>&2 2>&3)
            echo "$fileAction" >> "$pathSelect/$fileEdit"
            {
            for i in $(seq 0 5 100); do
                sleep 0.1  # simulate work
                echo $i
            done
            } | dialog --title "Updating" --gauge "Please wait..." 10 50 0
            dialog --title 'Done' --msgbox 'Content added successfully!' 10 50
            ;;
        *)
            dialog --title 'Error' --msgbox 'Incorrect choice' 10 50
            ;;
    esac

    # Ask user what to do next
    cont=$(dialog --title 'Next' --menu 'What do you want to do?' 10 50 3 \
    Y 'Update more files' \
    M 'Return to Main Menu' \
    N 'Exit' 3>&1 1>&2 2>&3)

    case $cont in
        Y) continue ;;  # Go back to the top of the loop to update more files
        M) exit 0 ;;    # Return control to mainFTCT.sh menu
        N) clear; exit 0 ;; # Exit the script
    esac
done
