#!/bin/bash

show_sintax () {
    echo
    echo 'Sintax:'
    echo "sudo $0 service_name shell_path install_path binary_name binary_path"
    echo
    exit 1
}

[[ $# -lt 5 ]] && show_sintax

if [ ! ${EUID:-$(id -u)} -eq 0 ] ; then
    echo "Must run with sudo!!"
    show_sintax
fi

SERVICE_NAME=$1
SHELL_PATH=$2
INSTALL_PATH=$3
BINARY=$4
BINARY_PATH=$5

if [[ ! -x $SHELL_PATH ]] ; then
    echo "Specified Shell not found!!"
    echo
    exit 3
fi

if [[ ! -d /etc/systemd/system ]] ; then
    echo "Services Folder not found!!"
    echo
    exit 2
fi

if [[ ! -x $BINARY_PATH/$BINARY ]] ; then
    echo "Binary to Install Not Found"
    echo
    exit 4
fi

exit

echo "Generating script run_service.sh"
./gen_script.sh $INSTALL_PATH $BINARY > run_service.sh

echo "Generating script $BINARY.service"
./gen_service.sh "$SERVICE_NAME" $SHELL_PATH $INSTALL_PATH > $BINARY.service

echo "Installing Program"
[[ ! -d $INSTALL_PATH ]] && mkdir $INSTALL_PATH
cp $BINARY_PATH/$BINARY $INSTALL_PATH
chmod 744 $INSTALL_PATH/$BINARY


echo "Installing Service"
cp $BINARY.service /etc/systemd/system/$BINARY.service
chmod 644 /etc/systemd/system/$BINARY.service


