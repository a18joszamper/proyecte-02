#!/bin/bash

if [[ "${UID}" -eq 0 ]]
then
	if [ -z "$1" ]
	then	
		if [ -z "$2" ]
			useradd -c "$2" -m "$1"
		else
			useradd -m "$1"
	fi

else
	echo 'No tienes los permisos necesarios.'
fi
