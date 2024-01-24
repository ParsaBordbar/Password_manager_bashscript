#!/bin/bash

clear

#Styles:

	#Font Variations
	bold="\e[1m"
	rbold="\e[22m"
	italic="\e[3m"
	ritalic="\e[23m"

	#Colors
	yellowText="\e[38;2;255;255;0m"
	yellowBg="\e[48;2;255;255;0m"
	blackText="\e[38;2;0;0;0m"
	blackBg="\e[48;2;0;0;0m"
	reset="\e[m"

#This is the database of our project:
password_database="password_database.txt"

if [ ! -e "$password_database" ]
then 
	touch "$password_database"
fi

#Makes new password
add_new_password(){
	clear
	read -p "Enter the account name: " account 
	read -p "Enter the password: " password
	echo "$account: $password" >> "$password_database"
	echo "The account $account was added succsesfuly."
}

#Gets the password
get_password(){
	clear
        read -p "Enter the account name: " account
	password=$(grep "^$account:" "$password_database" | cut -d " " -f 2)
    
	if [ -n "$password" ]; 
	then
        	echo "Password for $account: $password"
        else
        	echo "Password not found for $account."
    fi
}
#Generate a random pass word with length of 12
generate_password(){
	read -p "Enter the account name you want to generate a password for: " account
	length=12
	password=$(tr -dc 'a-zA-Z0-9@#$%^!~()' < /dev/urandom | fold -w ${length} | head -n 1)
	 echo "$password added for account ${account}"
	 echo "${yellowBg}$account: $password" >> "$password_database${reset}"
}

#Here we are Making a Menu for it
while true;
do
	echo -e "\n${bold}Password mangaer${rbold}"
	echo -e "1-Add new password"
	echo -e "2-Retrive password"
	echo -e "3-Generate password"
	echo -e "4-Quit" 
	read -p "Select an item: " choice 
	case $choice in 
		1) add_new_password;;
		2) get_password;;
		3) generate_password;;
		4) exit;;
		*) echo "Invalid Option"
	esac
done
