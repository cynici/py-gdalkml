#! /bin/sh
set -ux
adduser -u $RUNUSER_UID -h /home/runuser -D -s /bin/bash runuser
exec gosu runuser "$@"
