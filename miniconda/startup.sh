#!/bin/bash

# SUDO-related arguments are a workaround
# for https://github.com/conda/conda/issues/6576
# Shouldn't be needed once Conda 4.6 goes GA

exec sudo -u idies env \
	-u SUDO_UID -u SUDO_GID -u SUDO_COMMAND -u SUDO_USER \
	PATH=$PATH jupyter notebook \
    --no-browser \
    --ip=* \
    --notebook-dir=/home/idies/workspace \
    --NotebookApp.token='' \
    --NotebookApp.base_url=$1
