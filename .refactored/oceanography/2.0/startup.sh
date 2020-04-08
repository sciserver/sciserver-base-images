#!/bin/bash

sed -i 's|$PATH_PREFIX|'"$1"'|g' /etc/nginx/nginx.conf
nginx

exec sudo -u idies env PATH=$PATH jupyter notebook \
	--no-browser \
	--ip=* \
	--notebook-dir=/home/idies/workspace \
	--NotebookApp.token= \
	--KernelSpecManager.ensure_native_kernel=False \
	--NotebookApp.allow_remote_access=True \
	--NotebookApp.quit_button=False \
	--NotebookApp.base_url=$1
