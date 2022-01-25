#!/bin/bash

export SHELL=/bin/bash

jupyter lab \
	--no-browser \
	--ip=* \
	--NotebookApp.token= \
	--notebook-dir=/home/idies/workspace \
	--KernelSpecManager.ensure_native_kernel=False \
	--NotebookApp.allow_remote_access=True \
	--NotebookApp.quit_button=False \
	--NotebookApp.base_url=$1 \
	--ResourceUseDisplay.track_cpu_percent=True \
	--HdfConfig.resolve_links=True \
	--ContentsManager.allow_hidden=True
