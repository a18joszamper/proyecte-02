#!/bin/bash

usage() {
        echo "Usage: ${0} USERNAME [FULLNAME|COMMENT]" 1>&2; exit 1;
}

while getopts ":u:f" OPTION; do
        case "${OPTION}" in
                u)
                        USERNAME=${OPTARG}
                        ;;
                f)
                        FULLNAME=${OPTARG}
                        ;;
                \?)
                        usage
                        ;;
                :)
                        usage
                        ;;
        esac
done

#shift "$(( OPTIND - 1 ))"


if [[ "${UID}" -eq 0 ]]
then
        if [ -z "$USERNAME" ]
        then
                if [ -z "$FULLNAME" ]
                then
                        useradd -c "$FULLNAME" -m "$USERNAME"
                else
                        useradd -m "$USERNAME"
                fi
        else
                usage
        fi

else
        echo 'No tienes los permisos necesarios.'
fi

