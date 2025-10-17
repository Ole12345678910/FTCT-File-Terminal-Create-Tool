#!/bin/bash

echo -e "\e[32mScript running\e[0m"

read -p 'Where do you want to place the file?: ' folderPlace

if [[ ! -d "$folderPlace" ]]; then
    echo -e "\e[31mError: Folder does not exist!\e[0m"
    exit 1
fi


read -p $'\e[34mWhat is the name of the file?: \e[0m' fileName

read -p $'\e[34mWhat kind of file type do you want to make?: \e[0m' fileType

#checks if its a number, if not it will not allow

while true; do
    read -p $'\e[34mEnter number of files: \e[0m' fileNumber
    if [[ "$fileNumber" =~ ^[0-9]+$ ]]; then
        break
    else
        echo -e "\e[31mPlease enter a valid number!\e[0m"
    fi
done

for ((i=1; i<=fileNumber; i++))
do
    touch "$folderPlace/$fileName$i.$fileType" 
done

#asks if yes or no if the user wants to add contents to the file

while true; do
    read -p $'\e[33mDo you wish to add content to the files [y/n] ? \e[0m' yn

    case $yn in
        [Yy]* )
            read -p "Write the contents that should be in the files: " fileContent
            for ((i=1; i<=fileNumber; i++)); do
                echo "$fileContent" > "$folderPlace/$fileName$i.$fileType"
            done
            break
            ;;
        [Nn]* )
            exit
            ;;
        * )
            echo -e "\e[32mPlease answer yes or no.\e[0m"
            ;;
    esac
done

#loading bar

echo -n "Creating files"
for i in {1..20}; do
    sleep 0.1   # simulerer arbeid
    echo -n "."
done
echo " Done!"

#touch myFile.txt

#echo "te" > myFile.txt
#echo "test number 2" >> myFile.txt

#read -p "message: " msg

#read -p "Delay (sec): " sec
#sleep "$sec"

#echo -e "\e[1;33m🔔 Reminder: $msg\e[0m"

