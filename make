#!/bin/bash

# make sure we are in the same directory as the script.
DIR=$( cd "$( dirname "$0" )" && pwd ) 
cd $DIR

source ./config

# make autofs configs.
echo "building autofs configs in ./build"
mkdir ./build
mkdir ./build/auto.master.d/
cat > ./build/auto.master.d/sshfs.master << EOF
/media/sshfs /etc/auto.sshfs uid=$(id -u $USER),gid=$(id -g $USER),--timeout=30,--ghost
EOF
cat > ./build/auto.sshfs << EOF
$MOUNTPOINT -fstype=fuse,rw,nodev,nonempty,allow_other,reconnect,uid=$(id -u $USER),gid=$(id -g $USER),max_read=65536,compression=yes,auto_cache,no_check_root,kernel_cache :sshfs\#$USER@$HOST\:$REMOTEDIR
EOF

