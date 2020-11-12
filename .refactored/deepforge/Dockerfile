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

RUN conda install -y -n deepforge -c conda-forge nodejs=12 \
	&& conda clean -y --all

COPY --chown=idies:idies lab_extension /home/idies/lab_extension

RUN jupyter nbextension install /home/idies/lab_extension --user \
	&& jupyter nbextension enable lab_extension/main --user --section='common'

RUN jupyter kernelspec remove -f python3

RUN ipython profile create \
	&& printf "\nc.InteractiveShellApp.matplotlib = 'inline'\n" >> /home/idies/.ipython/profile_default/ipython_kernel_config.py

RUN printf 'export NODE_PATH=/home/idies/miniconda3/envs/deepforge/lib/node_modules\n' >> /home/idies/.bashrc

USER root

RUN sed -i 's|jupyter|export NODE_PATH=/home/idies/miniconda3/envs/deepforge/lib/node_modules\njupyter|g' /opt/startup.sh

USER idies

RUN source activate deepforge \
	&& npm install -g requirejs@2.3.5 rimraf@^2.4.0 superagent@3.8.3 @babel/runtime@^7.7.2 q@1.5.1 node-fetch@2.6.0 agentkeepalive@3.4.1 aws-sdk@2.624.0

RUN source activate deepforge \
	&& pip install plotly nbformat

RUN source activate deepforge \
	&& npm install -g ws@7.2.5
