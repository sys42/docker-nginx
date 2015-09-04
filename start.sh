#!/bin/sh

###############################################################################
#
# USAGE: start.sh [MOUNT-DECLARATIONS]
#
#   MOUNT-DECLARATIONS   any number of docker run mount declarations
#
# example:  
#
# ./start.sh -v $(pwd):/project -p 80:80 -p 443:443
#
# (*) mounts the current working directory to directory /project within the
#     container
# (*) maps host port 80 and 443 on any interface to container ports 80 and 443
#
#    Note that the UID and GID of user app  will be remapped to match the
#    UID/GUID of the user executing this script.
#
#    The init system (my_init --) will be started via ENTRYPOINT
#
###############################################################################
docker run -ti --rm "$@" $(cat REPO_AND_VERSION) \
       remapuser app $(id -u) $(id -g) bash
