#!/bin/bash

read -p 'Select witch path you want to update: ' pathSelect

#See if path exists
if [[ ! -d "$pathSelect" ]]; then
    echo -e "\e[31mError: Folder does not exist!\e[0m"
    exit 1
fi

read -p 'Select witch file you want to edit: ' fileEdit

#This gives user an message if they want to update yes or not and invalid if none are selected
while true; do

    read -p 'Do you want to update the file or add to it [u/a]?: ' decide

    case $decide in
        [Uu])
            action="update"   # lagrer hva som skal gjøres
            break
            ;;
        [Aa])
            action="add"
            break
            ;;
        *)
            echo "Incorrect choice"
            ;;
    esac
done

#checks if the action(users input) is either update or add
#and it also checks if the file exits

if [[ "$action" == "update" ]]; then
    if [[ -f "$pathSelect/$fileEdit" ]]; then
        read -p 'What do you want to update to the file ?: ' fileAction
        echo "$fileAction" > "$pathSelect/$fileEdit"
    else
        echo 'file does not exist or the name is wrong'
    fi

elif [[ "$action" == "add" ]]; then
    if [[ -f "$pathSelect/$fileEdit" ]]; then
        read -p 'What do you want to add to the file ?: ' fileAction
        echo "$fileAction" >> "$pathSelect/$fileEdit"
    else
        echo 'file does not exist or the name is wrong'
    fi
fi

echo "Successfully $action the file '$fileEdit'"



