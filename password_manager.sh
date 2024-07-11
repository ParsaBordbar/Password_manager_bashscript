#!/bin/bash

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

echo -e "${yellowText}${bold} 
 ____                                     _
|  _ \ __ _ ___ _____      _____  _ __ __| |    _ __ ___   __ _ _ __   __ _  __ _  ___ _ __
| |_) / _  / __/ __\ \ /\ / / _ \|  __/ _  |   |  _   _ \ / _  |  _ \ / _  |/ _  |/ _ \  __|
|  __/ (_| \__ \__ \  V  V / (_) | | | (_| |   | | | | | | (_| | | | | (_| | (_| |  __/ |
|_|   \__,_|___/___/ \_/\_/ \___/|_|  \__,_|___|_| |_| |_|\__,_|_| |_|\__,_|\__, |\___|_|
                                          |_____|                           |___/${rbold}${reset}
"

# Check if .env file exists
if [ -f .env ]; 
then 
    export $(cat .env | xargs)
else
    echo ".env file not found. Please create one."
    exit 1
fi

create_database() {
    mysql -u "$DB_USER" -p"$DB_PASSWORD" -h "$DB_HOST" -e "
    CREATE DATABASE IF NOT EXISTS $DB_NAME;" 2>/dev/null
}

execute_query(){
    local query="$1"
    mysql -u "$DB_USER" -p"$DB_PASSWORD" -h "$DB_HOST" -D "$DB_NAME" -e "$query" 2>/dev/null
}

create_table() {
    execute_query "CREATE TABLE IF NOT EXISTS passwords (
        id INT AUTO_INCREMENT PRIMARY KEY,
        account VARCHAR(255) NOT NULL,
        password VARCHAR(255) NOT NULL);" 2>/dev/null
}

add_new_password(){
    clear
    echo -e "${yellowBg}${blackText} YOU ARE HERE: Adding new password ${reset}${reset}"
    echo -e "${italic}-for back type: .. ${ritalic}\n"
    read -p "Enter the account name: " account

    read -sp "Enter the password: " password

    execute_query "INSERT INTO passwords (account, password) VALUES ('$account', '$password');" 2>/dev/null
    echo -e "\nThe account $account was added successfully.\n"
}

get_password(){
    clear
    echo -e "${yellowBg}${blackText} YOU ARE HERE: Retrieving password ${reset}${reset}"
    echo -e "${italic}-for back type: .. ${ritalic}\n"
    read -p "Enter the account name: " account

    password=$(execute_query "SELECT password FROM passwords WHERE account='$account';")
    if [ -n "$password" ]; 
    then
        echo -e "\n${italic}Password for $account${ritalic}:\n ${yellowText} $password ${reset}\n"
    else
        echo -e "\nPassword not found for $account.\n"
    fi
}

generate_password(){
    clear
    echo -e "${yellowBg}${blackText} YOU ARE HERE: Generate Password ${reset}${reset}"
    echo -e "${italic}-for back type: .. ${ritalic}\n"
    read -p "Enter the account name you want to generate a password for: " account

    length=12
    password=$(tr -dc 'a-zA-Z0-9@#$%^!~()' < /dev/urandom | fold -w ${length} | head -n 1)
    execute_query "INSERT INTO passwords (account, password) VALUES ('$account', '$password');" 2>/dev/null
    echo -e "${yellowText}$password${reset} ${italic}added as password for account ${account}\n ${ritalic}"
}

generate_hash(){
    clear
    echo -e "${yellowBg}${blackText} YOU ARE HERE: Generating Hash ${reset}${reset}"
    echo -e "${italic}-for back type: .. ${ritalic}\n"
    read -p "Enter the account name: " account

    password=$(execute_query "SELECT password FROM passwords WHERE account='$account';")
    if [ -n "$password" ]; 
    then
        echo -e -n "$password" | sha256sum
        echo -e "\n"
    else
        echo -e "\nPassword not found for $account.\n"
    fi
}

show_database(){
    clear
    echo -e "\n${yellowBg}${blackText} YOU ARE HERE: Displaying Password Database ${reset}${reset}"
    echo -e "${italic}-for back type: .. ${ritalic}\n"
    execute_query "SELECT account, password FROM passwords;" 2>/dev/null
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

# Function to display the main menu and handle user input
main_menu(){
    while true;
    do
        echo -e "${yellowBg}${blackText} YOU ARE HERE: Password Manager Menu ${reset}${reset}"
        echo -e "${yellowText}|${reset}"
        echo -e "${yellowText}| 1)${reset} Add new password"
        echo -e "${yellowText}| 2)${reset} Retrieve password"
        echo -e "${yellowText}| 3)${reset} Generate password"
        echo -e "${yellowText}| 4)${reset} Show password database"
        echo -e "${yellowText}| 5)${reset} Generate hash for password"
        echo -e "${yellowText}| 6)${reset} Quit\n"
        read -p "Select an option: " choice
    
        case $choice in 
            1) add_new_password;;
            2) get_password;;
            3) generate_password;;
            4) show_database;;
            5) generate_hash;;
            6) exit;;
            *) echo "Invalid Option\n";;
        esac
    done
}

create_database
create_table
log_in
main_menu
