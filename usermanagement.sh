#!/bin/bash

#---------------------------
# User Management Functions
#---------------------------

# Function to create a user
create_user() {
    read -p "Enter username to create: " username
    if id "$username" &>/dev/null; then
        echo "User $username already exists."
    else
        sudo useradd "$username"
        echo "User $username created."
    fi
}

# Function to delete a user
delete_user() {
    read -p "Enter username to delete: " username
    if id "$username" &>/dev/null; then
        sudo userdel -r "$username"
        echo "User $username deleted."
    else
        echo "User $username does not exist."
    fi
}

# Function to add user to a group
add_to_group() {
    read -p "Enter username to add to a group: " username
    read -p "Enter group name: " groupname
    if id "$username" &>/dev/null; then
        sudo usermod -aG "$groupname" "$username"
        echo "User $username added to group $groupname."
    else
        echo "User $username does not exist."
    fi
}

# Function to remove user from a group
remove_from_group() {
    read -p "Enter username to remove from a group: " username
    read -p "Enter group name: " groupname
    if id "$username" &>/dev/null; then
        sudo deluser "$username" "$groupname"
        echo "User $username removed from group $groupname."
    else
        echo "User $username does not exist."
    fi
}

#---------------------------
# Backup Function
#---------------------------

backup_directory() {
    read -p "Enter the directory path to backup: " dir
    if [ -d "$dir" ]; then
        timestamp=$(date +"%Y%m%d%H%M")
        backup_name="backup_$(basename "$dir")_$timestamp.tar.gz"
        tar -czvf "$backup_name" "$dir"
        echo "Backup of $dir completed and saved as $backup_name."
    else
        echo "Directory $dir does not exist."
    fi
}

#---------------------------
# Menu Interface
#---------------------------

while true; do
    echo "----- User Management & Backup Script -----"
    echo "1. Create a User"
    echo "2. Delete a User"
    echo "3. Add User to a Group"
    echo "4. Remove User from a Group"
    echo "5. Backup a Directory"
    echo "6. Exit"
    read -p "Choose an option [1-6]: " choice

    case $choice in
        1) create_user ;;
        2) delete_user ;;
        3) add_to_group ;;
        4) remove_from_group ;;
        5) backup_directory ;;
        6) echo "Exiting..."; exit ;;
        *) echo "Invalid option. Please choose again." ;;
    esac
done

