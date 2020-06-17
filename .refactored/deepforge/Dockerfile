FROM dockerregistry:443/sciserver-jupyter

USER idies

COPY --chown=idies:idies deepforge-env.yml /home/idies/deepforge-env.yml

RUN conda update -y conda \
	&& conda env create -n deepforge --file /home/idies/deepforge-env.yml \
	&& source activate deepforge \
	&& conda install -y ipykernel \
	&& conda clean -y --all \
	&& python -m ipykernel install --user --name deepforge --display-name "Python 3.7 (deepforge)" \
	&& /bin/bash -c 'printf "source activate deepforge\n" >> ~/.bashrc'

RUN conda install -y -n deepforge nodejs \
	&& conda clean -y --all

COPY --chown=idies lab_extension /home/idies/lab_extension

RUN jupyter nbextension install /home/idies/lab_extension --user \
	&& jupyter nbextension enable lab_extension/main --user --section='common'

RUN jupyter kernelspec remove -f python3

RUN ipython profile create \
	&& printf "\nc.InteractiveShellApp.matplotlib = 'inline'\n" >> /home/idies/.ipython/profile_default/ipython_kernel_config.py

