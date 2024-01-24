# Password_manager_bashscript


PASSWORD=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w ${LENGTH} | head -n 1)
