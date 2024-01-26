#!/bin/bash

clear

#Styles:

	#Font Variations
	bold="\e[1m"
	rbold="\e[22m"
	blackBg="\e[48;2;0;0;0m"
	reset="\e[m"


echo -e "${yellowText} 
 ____                                     _
|  _ \ __ _ ___ _____      _____  _ __ __| |    _ __ ___   __ _ _ __   __ _  __ _  ___ _ __
| |_) / _  / __/ __\ \ /\ / / _ \|  __/ _  |   |  _   _ \ / _  |  _ \ / _  |/ _  |/ _ \  __|
|  __/ (_| \__ \__ \  V  V / (_) | | | (_| |   | | | | | | (_| | | | | (_| | (_| |  __/ |
|_|   \__,_|___/___/ \_/\_/ \___/|_|  \__,_|___|_| |_| |_|\__,_|_| |_|\__,_|\__, |\___|_|
                                          |_____|                           |___/${reset}
"
#This is the database of our project:
password_database="password_database.txt"

#Makes new password
add_new_password(){
	clear
	echo -e "${blackBg}${yellowText}${bold}Adding new password${rbold}${reset}${reset}\n"
	read -p "Enter the account name: " account 
	read -p "Enter the password: " password
	echo "$account: $password" >> "$password_database"
	echo "The account $account was added succsesfuly."
	echo -e "\nThe account $account was added succsesfuly.\n"
}

#Gets the password
get_password(){
	clear
	echo -e "${blackBg}${yellowText}${bold}Retriveing password${rbold}${reset}${reset}\n"
        read -p "Enter the account name: " account
	password=$(grep "^$account:" "$password_database" | cut -d " " -f 2)

	if [ -n "$password" ]; 
	then
        	echo "Password for $account: $password"
        	echo -e "\n${italic}Password for $account${ritalic}:\n ${yellowText} $password ${reset}\n"
        else
        	echo "Password not found for $account."
        	echo -e "\nPassword not found for $account."
    fi
}

#Generate a random pass word with length of 12
generate_password(){
	clear
	echo -e "${blackBg}${yellowText}${bold}Genrate Password${rbold}${reset}${reset}\n"
	read -p "Enter the account name you want to generate a password for: " account
	length=12
	password=$(tr -dc 'a-zA-Z0-9@#$%^!~()' < /dev/urandom | fold -w ${length} | head -n 1)
	 echo "$password added for account ${account}"
	 echo "${yellowBg}$account: $password" >> "$password_database${reset}"
	echo -e "${yellowText}$password${reset} ${italic}added as password for account ${account}\n ${ritalic}"
	echo -e "${yellowBg}$account: $password" >> "$password_database ${reset}"
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
main_menu(){
	while true;
	do
		echo -e "${blackBg}${yellowText}${bold}Password mangaer menu${rbold}${reset}${reset}\n"
		echo -e "1-Add new password"
		echo -e "2-Retrive password"
		echo -e "3-Generate password"
		echo -e "4-Quit\n"
        	read -p "Select an option: " choice	
		case $choice in 
			1) add_new_password;;
			2) get_password;;
			3) generate_password;;
			4) exit;;
			*) echo "Invalid Option"
		esac
	done
}

main_menu
