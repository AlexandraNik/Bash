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
	read -p "Enter a user name: " username
	adduser "$username"

	read -s -p "Enter a password: " password
	echo "$password" | passwd --stdin "$username"

	read -p "Enter a group name: " gname
        usermod -a -G "$gname" "$username"

	read -p "Choose home directory: " hdir
	usermod -m -d "$hdir" "$username"

fi	
