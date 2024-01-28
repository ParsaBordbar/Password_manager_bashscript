#!/bin/bash

clear
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


echo -e "${yellowText}${bold} 
 ____                                     _
|  _ \ __ _ ___ _____      _____  _ __ __| |    _ __ ___   __ _ _ __   __ _  __ _  ___ _ __
| |_) / _  / __/ __\ \ /\ / / _ \|  __/ _  |   |  _   _ \ / _  |  _ \ / _  |/ _  |/ _ \  __|
|  __/ (_| \__ \__ \  V  V / (_) | | | (_| |   | | | | | | (_| | | | | (_| | (_| |  __/ |
|_|   \__,_|___/___/ \_/\_/ \___/|_|  \__,_|___|_| |_| |_|\__,_|_| |_|\__,_|\__, |\___|_|
                                          |_____|                           |___/${rbold}${reset}
"
#This is the database of our project:
password_database="password_database.txt"

if [ ! -e "$password_database" ]
then 
	touch "$password_database"
fi

chmod 600 "$password_database"

retuen_to_main_menu(){
	if [ "$1" == '..' ];
	then
		echo -e '\n'
		main_menu
	fi
}

#Makes new password
add_new_password(){
	clear
	echo -e "${yellowBg}${blackText} YOU ARE HERE: Adding new password ${reset}${reset}"
	echo -e "${italic}-for back type: .. ${ritalic}\n"
	read -p "Enter the account name: " account
	retuen_to_main_menu "$account"
	read -sp "Enter the password: " password
	retuen_to_main_menu $password
	echo "$account: $password" >> "$password_database"
	echo -e "\nThe account $account was added succsesfuly.\n"
}

#Gets the password
get_password(){
	clear
	echo -e "${yellowBg}${blackText} YOU ARE HERE: Retriveing password ${reset}${reset}"
	echo -e "${italic}-for back type: .. ${ritalic}\n"
    read -p "Enter the account name: " account
	retuen_to_main_menu $account
	password=$(grep "^$account:" "$password_database" | cut -d " " -f 2)
	if [ -n "$password" ]; 
	then
        	echo -e "\n${italic}Password for $account${ritalic}:\n ${yellowText} $password ${reset}\n"
        else
        	echo -e "\nPassword not found for $account."
    fi
}

#Generate a random pass word with length of 12
generate_password(){
	clear
	echo -e "${yellowBg}${blackText} YOU ARE HERE: Genrate Password ${reset}${reset}"
	echo -e "${italic}-for back type: .. ${ritalic}\n"
	read -p "Enter the account name you want to generate a password for: " account
	retuen_to_main_menu $account
	length=12
	password=$(tr -dc 'a-zA-Z0-9@#$%^!~()' < /dev/urandom | fold -w ${length} | head -n 1)
	echo -e "${yellowText}$password${reset} ${italic}added as password for account ${account}\n ${ritalic}"
	echo -e "${yellowBg}$account: $password" >> "$password_database ${reset}"
}

#Hashes your desired passwords using sha256
generate_hash(){
	clear
	echo -e "${yellowBg}${blackText} YOU ARE HERE: Generating Hash ${reset}${reset}"
	echo -e "${italic}-for back type: .. ${ritalic}\n"
	read -p "Enter the account name: " account
	retuen_to_main_menu $account
	password=$(grep "^$account:" "$password_database" | cut -d " " -f 2)
	if [ -n "$password" ]; 
	then
		echo -e -n $"$password" | sha256sum
		echo -e "\n"
	else
		echo -e "\nPassword not found for $account.\n"
	fi
}

show_database(){
	clear
	echo -e "\n${yellowBg}${blackText} YOU ARE HERE: Displaying Password Database ${reset}${reset}"
	echo -e "${italic}-for back type: .. ${ritalic}\n"
	cat "$password_database"
	echo -e "\n"
}

log_in(){
	read -sp  "Enter the 'KEY' to continue: " input
	key="vader"
	salt="sith"
	hashed_input=$(echo -n "${key}${salt}" | sha256sum) 
	hashed_key=$(echo -n "${input}${salt}" | sha256sum) 

	while [ "$hashed_input" != "$hashed_key" ];
	do
		read -p  "Enter the 'KEY' to continue: " input
		hashed_key=$(echo -n "${input}${salt}" | sha256sum) 
	done
	clear
	echo -e "${yellowBg}${blackText} Welcome! ${reset}${reset}\n\n"
}


#Here we are Making a Menu for it
main_menu(){
	while true;
	do
		echo -e "${yellowBg}${blackText} YOU ARE HERE: Password mangaer menu ${reset}${reset}"
		echo -e "${yellowText}|${reset}"
		echo -e "${yellowText}| 1)${reset} Add new password"
		echo -e "${yellowText}| 2)${reset} Retrive password"
		echo -e "${yellowText}| 3)${reset} Generate password"
		echo -e "${yellowText}| 4)${reset} Show password database"
		echo -e "${yellowText}| 5)${reset} Generate hash for password"
		echo -e "${yellowText}| 6)${reset} Quit\n"
        	read -p " Select an option: " choice	
		case $choice in 
			1) add_new_password;;
			2) get_password;;
			3) generate_password;;
			4) show_database;;
			5) generate_hash;;
			6) exit;;
			*) echo "Invalid Option\n"
		esac
	done
}
log_in
main_menu
