
![banner](https://github.com/ParsaBordbar/Password_manager_bashscript/assets/124056966/22c412ca-d70e-412b-9e01-0a03b43fe733)

# Bash Password Manager

This repository contains a simple password manager script written in Bash. The script provides a menu-driven interface to add, retrieve, and generate passwords for different accounts.

## Features
![menu](https://github.com/ParsaBordbar/Password_manager_bashscript/assets/124056966/1c6c502d-9406-4fa5-919a-511bd619267f)

- **Add New Password**: This feature allows you to add a new password for a specific account.

- **Retrieve Password**: This feature retrieves the password for a specified account.

- **Generate Password**: This feature generates a random password for a specified account.


![hasher](https://github.com/ParsaBordbar/Password_manager_bashscript/assets/124056966/1515364a-8f86-4a55-ba97-9dd9b451bfc1)  
- **Generate Hash:** This function generates a hash for the password of a specified account. It first clears the screen, then prompts the user to enter the account name. If the account exists in the password database, it generates a SHA256 hash of the password and displays it. If the account does not exist, it informs the user that the password was not found.

- **Show Database:** This function displays the entire password database. It first clears the screen, then reads and displays the contents of the password database file.

- **Log In:** This function handles user authentication. It prompts the user to enter a key. The entered key is hashed and compared with a pre-defined hashed key. If the keys match, the user is granted access and a welcome message is displayed. If the keys do not match, the user is prompted to enter the key again.

Return to Main Menu: This function checks if the user input is “…”. If it is, the function returns to the main menu.

## Usage
1. Clone the repository to your local machine.
2. Navigate to the directory containing the script.
3. Run the script using the command `bash password_manager.sh`.
4. Follow the prompts in the terminal to manage your passwords.

## Code
The script is contained in a single file, `password_manager.sh`.
