#!/bin/bash

# Clear the terminal
clear

# Font Variations
bold="\e[1m"
rbold="\e[22m"
italic="\e[3m"
ritalic="\e[23m"

# Colors
yellowText="\e[38;2;255;255;0m"
yellowBg="\e[48;2;255;255;0m"
blackText="\e[38;2;0;0;0m"
blackBg="\e[48;2;0;0;0m"
reset="\e[m"

# Display the banner
echo -e "${yellowText} 
 ____                                     _
|  _ \ __ _ ___ _____      _____  _ __ __| |    _ __ ___   __ _ _ __   __ _  __ _  ___ _ __
| |_) / _  / __/ __\ \ /\ / / _ \|  __/ _  |   |  _   _ \ / _  |  _ \ / _  |/ _  |/ _ \  __|
|  __/ (_| \__ \__ \  V  V / (_) | | | (_| |   | | | | | | (_| | | | | (_| | (_| |  __/ |
|_|   \__,_|___/___/ \_/\_/ \___/|_|  \__,_|___|_| |_| |_|\__,_|_| |_|\__,_|\__, |\___|_|
                                          |_____|                           |___/${reset}
"

# This is the database of our project:
password_database="password_database.txt"

# Create the database file if it doesn't exist
if [ ! -e "$password_database" ]
then 
	touch "$password_database"
fi

# Secure the database file
chmod 600 "$password_database"

# Function to add a new password
add_new_password(){
	clear
	echo -e "${blackBg}${yellowText}${bold}Adding new password${rbold}${reset}${reset}\n"
	read -p "Enter the account name: " account 
	read -sp "Enter the password: " password
	hashed_password=$(echo -n "$password" | openssl dgst -sha256)
	echo "$account: $hashed_password" >> "$password_database"
	echo -e "\nThe account $account was added successfully.\n"
}

# Function to retrieve a password
get_password(){
	clear
	echo -e "${blackBg}${yellowText}${bold}Retrieving password${rbold}${reset}${reset}\n"
	read -p "Enter the account name: " account
	read -sp "Enter the password: " password
	hashed_password=$(grep "^$account:" "$password_database" | cut -d ":" -f 2)
	input_password_hash=$(echo -n "$password" | openssl dgst -sha256)
	if [ "$input_password_hash" == "$hashed_password" ]; 
	then
        	echo -e "\nPassword for $account is correct.\n"
	else
        	echo -e "\nIncorrect password for $account."
	fi
}


# Function to generate a password
generate_password(){
	clear
	echo -e "${blackBg}${yellowText}${bold}Generate Password${rbold}${reset}${reset}\n"
	read -p "Enter the account name you want to generate a password for: " account
	length=12
	password=$(tr -dc 'a-zA-Z0-9@#$%^!~()' < /dev/urandom | fold -w ${length} | head -n 1)
	echo -e "${yellowText}$password${reset} ${italic}added as password for account ${account}\n ${ritalic}"
	echo -e "${yellowBg}$account: $password" >> "$password_database ${reset}"
}

# Function to delete a password
delete_password(){
	clear
	echo -e "${blackBg}${yellowText}${bold}Deleting password${rbold}${reset}${reset}\n"
	read -p "Enter the account name: " account
	grep -v "^$account:" "$password_database" > "temp.txt" && mv "temp.txt" "$password_database"
	echo -e "\nThe password for account $account was deleted successfully.\n"
}

# Main menu function
main_menu(){
	while true;
	do
		echo -e "${blackBg}${yellowText}${bold}Password manager menu${rbold}${reset}${reset}\n"
		echo -e "1-Add new password"
		echo -e "2-Retrieve password"
		echo -e "3-Generate password"
		echo -e "4-Delete password"
		echo -e "5-Quit\n"
        	read -p "Select an option: " choice	
		case $choice in 
			1) add_new_password;;
			2) get_password;;
			3) generate_password;;
			4) delete_password;;
			5) exit;;
			*) echo "Invalid Option"
		esac
	done
}

# Call the main menu function
main_menu
