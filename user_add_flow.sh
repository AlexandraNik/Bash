#!/usr/bin/env bash

#############################
# uname, group, passwd, homedir
#
#
###############################

if [[  "$UID" != "0" ]]; then

	echo "You do not have root permissions!"
	exit 1

else
	read -p "Enter a user name: " username
	adduser $username

	read -p -s "Enter a password: " pasword
	echo $pasword | passwd --stdin $username

	read -p "Enter a group name: " gname
        usermod -a -G $gname $username

	#read -p "Choose home directory: " hdir
	#usermod -m -d "$hdir" $username

fi	
