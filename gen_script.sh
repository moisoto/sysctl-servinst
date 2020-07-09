#!/bin/bash

[[ $# -lt 2 ]] && exit

#define parameters which are passed in.
INSTALL_PATH=$1
BINARY=$2

#define the template.
cat  << EOF
DATE=\`date '+%Y-%m-%d %H:%M:%S'\`
echo "Service started at \${DATE}" | systemd-cat -p info

cd $INSTALL_PATH 
./$BINARY
EOF
