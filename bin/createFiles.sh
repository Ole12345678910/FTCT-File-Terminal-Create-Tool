#!/bin/bash

#Main loop
while true; do

    #Ask for folder path
    folderPlace=$(dialog --clear --title 'Select path' --inputbox 'Where do you want to place the file?:' 10 50 3>&1 1>&2 2>&3)

    if [[ ! -d "$folderPlace" ]]; then
        dialog --msgbox "Error: Folder does not exist!" 10 50
        continue  # Go back to start instead of exiting
    fi

    #Ask for file name
    fileName=$(dialog --clear --title 'Name the file' --inputbox 'What is the name of the file?: ' 10 50 3>&1 1>&2 2>&3)

    #Ask for file type
    fileType=$(dialog --clear --title 'Name the file type' --inputbox 'What kind of file type do you want to make?: ' 10 50 3>&1 1>&2 2>&3)

    #Ask for how many files to create (must be number)
    while true; do
        fileNumber=$(dialog --clear --title 'Number of files' --inputbox 'Enter number of files: ' 10 50 3>&1 1>&2 2>&3)
        if [[ "$fileNumber" =~ ^[0-9]+$ ]]; then
            break
        else
            dialog --clear --title 'Error' --msgbox 'Please enter a valid number!' 10 50 
        fi
    done

    #Create the files
    for ((i=1; i<=fileNumber; i++)); do
        touch "$folderPlace/$fileName$i.$fileType"
    done

    #Ask if user wants to add content
    yn=$(dialog --clear --title 'Add content to files?' --menu 'Do you wish to add content to the files [y/n] ?' 10 50 3 \
        Y 'Add content to files' \
        N 'No, don’t add content' \
        3>&1 1>&2 2>&3)

    case $yn in
        Y)
            fileContent=$(dialog --clear --title 'Write the content' --inputbox 'Write the contents that should be in the files: ' 10 50 3>&1 1>&2 2>&3)
            for ((i=1; i<=fileNumber; i++)); do
                echo "$fileContent" > "$folderPlace/$fileName$i.$fileType"
            done
            ;;
        N)
            ;;
    esac

    #Loading bar (visual feedback)
    {
    for i in $(seq 0 5 100); do
        sleep 0.1
        echo $i
    done
    } | dialog --title "Updating" --gauge "Please wait..." 10 50 0

    dialog --title 'Done' --msgbox 'Files created successfully!' 10 50

    #Ask if user wants to create more, return, or exit
    continue=$(dialog --clear --title 'Create more files?' --menu 'Would you like to create more files? [y/n/main] ? ' 15 50 4 \
        Y 'Create more files' \
        M 'Return to Main Menu' \
        N 'Exit' 3>&1 1>&2 2>&3)

    case $continue in
        Y) clear; continue ;;  # Start loop again (create more)
        M) clear; exit 0 ;;    # Return to main menu (mainFTCT.sh)
        N) clear; exit 0 ;;    # Exit the script completely
    esac

done



