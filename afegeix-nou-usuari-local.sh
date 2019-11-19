#!/bin/bash

usage() {
        echo "Usage:"
	echo "${0} [-u <USERNAME>] [-f <FULLNAME>|<COMMENT>]" 1>&2; exit 1;
}


while getopts :u:f o; do
        case "${o}" in
                u)
                        USERNAME=${OPTARG}
                        ;;
                f)
                        FULLNAME=${OPTARG}
                        ;;
                \?)

			echo "ERROR: Invalid option -$OPTARG"
                        usage
                        ;;
                :)
			echo "ERROR: Option -$OPTARG requires an argument"
			usage
                        ;;
        esac
done

shift $((OPTIND-1))

PASSWORD=`openssl rand -base64 15`

if [[ "${UID}" -eq 0 ]]
then
        if [ ! -z "$USERNAME" ]
        then
                if [ -z "$FULLNAME" ]
                then
                        useradd -m "$USERNAME" -p "$PASSWORD"
                else
                        useradd -c "$FULLNAME" -m "$USERNAME" -p "$PASSWORD"
                fi
		echo $USERNAME:$PASSWORD | chpasswd
		echo "La cuenta ha sido creada."
		echo "El usuario es: $USERNAME"
		echo "La contraseña: $PASSWORD"
		echo "El hostname es: `hostname`"
	else
		usage
        fi

else
        echo 'No tienes los permisos necesarios.'
fi


