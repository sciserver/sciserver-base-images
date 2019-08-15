#!/bin/bash

nginx

# SUDO-related arguments are a workaround
# for https://github.com/conda/conda/issues/6576
# Shouldn't be needed once Conda 4.6 goes GA

cd /home/idies/workspace
exec sudo -u idies env \
	-u SUDO_UID -u SUDO_GID -u SUDO_COMMAND -u SUDO_USER \
	PATH=$PATH /usr/lib/rstudio-server/bin/rserver --rsession-ld-library-path=/home/idies/miniconda3/lib
