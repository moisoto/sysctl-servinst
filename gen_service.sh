#!/bin/bash

[[ $# -lt 3 ]] && exit

#define parameters which are passed in.
SERVICE_NAME=$1
SHELL_PATH=$2
INSTALL_PATH=$3

#define the template.
cat  << EOF
[Unit]
Description=$SERVICE_NAME

[Service]
Type=simple
ExecStart=$SHELL_PATH $INSTALL_PATH/run_service.sh

[Install]
WantedBy=multi-user.target
EOF
