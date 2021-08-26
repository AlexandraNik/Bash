#!/usr/bin/env bash

#############################
# author: purple-thistle
#
# interactively ask for username, group, passwd, homedir
#
# perform task only for user with root priviliges
###############################

if [[  "$UID" != "0" ]]; then

	echo "You do not have root permissions!"
	exit 1

else
	#username
	read -p "Enter a user name: " username
	
	res=$(cat /etc/passwd | grep "$username")
	if [[ -z "$res" ]]; then
		useradd "$username"
	else
		echo "User already exists"
		exit 1
	fi	
	
	
	
	#password
	read -s -p "Enter a password: " password
	
	while [[ ${#password} < 6 ]]; do
		read -s -p "Password should be at least 6 characters long. Try again: " password
	done		

	echo "$password" | passwd --stdin "$username"
	

	#group
	read -p "Enter a group name: " gname
	
	res=$(cat /etc/group | grep "$gname")
	if [[ -z "$res" ]]; then
		read -p "Group does not exist. To create press 'y'." ans
		if [[ "$ans" == "y" ]]; then
			groupadd "$gname"
		fi	
	fi	

        usermod -a -G "$gname" "$username"


	#home dir
	read -p "Choose home directory: " hdir
	usermod -m -d "$hdir" "$username"

fi	
