#!/bin/bash

SERVICE_NAME="Your Web Service Description" # Descriptive Service Name
SHELL_PATH=/bin/bash
BINARY=myservice # Specify your service binary file here
INSTALL_PATH=/home/ubuntu/services/$BINARY
BINARY_PATH=..

if [ ! ${EUID:-$(id -u)} -eq 0 ] ; then
    echo "Must run with sudo!!"
    echo
    echo 'Sintax:'
    echo "sudo $0"
    echo
    exit 1
fi

./install_helper.sh "$SERVICE_NAME" $SHELL_PATH $INSTALL_PATH $BINARY $BINARY_PATH
[[ ! $? -eq 0 ]] && exit

cp run_service.sh $BINARY_PATH/config.json $BINARY_PATH/server.key $BINARY_PATH/server.crt $INSTALL_PATH

echo "Install Finished!!!"
echo
echo "------------------------"
echo
echo "To Start:"
echo "sudo systemctl start $BINARY"
echo
echo "To Stop:"
echo "sudo systemctl stop $BINARY"
echo
echo "To Status:"
echo "sudo systemctl status $BINARY"
echo
echo "To enable run on Startup:"
echo "sudo systemctl enable $BINARY"
echo
