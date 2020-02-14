#!/bin/bash

export SHELL=/bin/bash

echo source /home/idies/lsst/loadLSST.bash >> /home/idies/.bashrc

bash -c "source /home/idies/lsst/loadLSST.bash \
	&& setup lsst_sims -t sims_w_2020_06 \
	&& jupyter notebook \
		--no-browser \
		--ip=* \
		--notebook-dir=/home/idies/workspace \
		--NotebookApp.token= \
		--KernelSpecManager.ensure_native_kernel=False \
		--NotebookApp.allow_remote_access=True \
		--NotebookApp.quit_button=False \
		--NotebookApp.base_url=$1"
