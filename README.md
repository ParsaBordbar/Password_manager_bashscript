
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

- **Return to Main Menu:** This function checks if the user input is “…”. If it is, the function returns to the main menu.



### Environment Setup

Firstly be sure you have mysql on you mechine if not install it using:
```
sudo apt-get update
sudo apt-get install mysql-client
```


1. **Clone the Repository:**

   ```bash
   git clone https://github.com/your_username/password-manager.git
   cd password-manager
   ```

2. **Copy `.env.example` to `.env`:**

   ```bash
   cp .env.example .env
   ```

   Edit `.env` and replace placeholders with your actual MySQL database credentials:

   ```
   DB_USER=your_db_user
   DB_PASSWORD=your_db_password
   DB_HOST=your_db_host
   DB_NAME=your_db_name
   ```

3. **Create `.my.cnf` File:**

   Create a `.my.cnf` file in your home directory (`~/.my.cnf`) with your MySQL credentials:

   ```
   [client]
   user=your_mysql_user
   password=your_mysql_password
   host=your_mysql_host
   ```

   Secure the file with appropriate permissions:

   ```bash
   chmod 600 ~/.my.cnf
   ```

## Usage

Once you have set up your environment and configured the necessary files, you can use the password manager script (`password_manager.sh`) to manage passwords:

1. **Add New Password:**

   - Select option `1` from the main menu.
   - Enter the account name and password when prompted.

2. **Retrieve Password:**

   - Select option `2` from the main menu.
   - Enter the account name to retrieve the corresponding password.

3. **Generate Password:**

   - Select option `3` from the main menu.
   - Enter the account name for which you want to generate a random password.

4. **Show Password Database:**

   - Select option `4` from the main menu.
   - Displays all accounts and their corresponding passwords stored in the database.

5. **Generate Hash for Password:**

   - Select option `5` from the main menu.
   - Enter the account name to generate a hash of the corresponding password using SHA-256.

6. **Quit:**

   - Select option `6` from the main menu to exit the password manager.

**Security Note:** Ensure that sensitive files like `.env` and `.my.cnf` are not committed to your Git repository to protect your database credentials and other sensitive information.

## Contributing

Feel free to fork this repository, make improvements, and submit pull requests. If you encounter any issues or have suggestions, please open an issue.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
```

Please replace placeholders (`your_username`, `your_db_user`, `your_db_password`, etc.) with your actual values and customize any paths or details based on your specific project requirements. This structure provides clear setup instructions and usage guidelines for users of your password manager script.

## Code
The script is contained in a single file, `password_manager.sh`.
