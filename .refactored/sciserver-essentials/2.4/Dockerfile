FROM sciserver-essentials:2.3
# Update pip
RUN python -m pip install --no-cache --upgrade pip

RUN source activate py38 && python -m pip install --no-cache --upgrade pip

# Update jupyterlab and ipykernel that supports debugging

RUN pip install --no-cache jupyterlab==3.2.1

RUN source activate py38 \
	&& pip install --upgrade --no-cache ipykernel \
	&& python -m ipykernel install --user --name py38 --display-name "Python 3.8 (py38)"

# update nodejs

RUN mamba install -c conda-forge nodejs=16.10.0 

# uninstall and then clean install versions compatible with newer jupyter

RUN mamba uninstall jupyterlab_widgets

RUN jupyter labextension uninstall \
	@jupyter-widgets/jupyterlab-manager \
	jupyter-leaflet \
	jupyterlab-plotly \
	plotlywidget \
	&& jupyter lab clean \
	&& jlpm cache clean

RUN mamba uninstall \
	jupyterlab_widgets \
	ipywidgets \
	ipyleaflet \
	plotly \
	&& conda clean -y --all

RUN mamba install -c conda-forge \
	jupyterlab_widgets \
	ipywidgets \
	ipyleaflet \
	plotly \
	&& conda clean -y --all

RUN mamba update -n py38 -y -c conda-forge \
	ipyleaflet \
	plotly \
	&& conda clean -y --all

# install new packages

RUN mamba install -y -n base  -c conda-forge \
	jupyter-server-proxy \
	jupyterlab_code_formatter \
	black \
	isort \
	mamba_gator \
	jupyterlab-spellchecker \
	jupyterlab-git \
	ipympl \
	jupyterlab-lsp \
	python-lsp-server \
	r-languageserver \
	jupyterlab_execute_time \
	jupyter-archive \
	jlab-enhanced-cell-toolbar \
	jupyter_bokeh \
	jupyter-dash \
	voila \
	ipyvolume \
	&& conda clean -y --all

RUN mamba install -y -n py38 -c conda-forge \
	jupyter_bokeh \
	jupyter-dash \
	voila \
	ipyvolume \
	&& conda clean -y --all

RUN mamba install -y -n py38 -c pyviz \
	panel \
	holoviews \
	datashader \
	geoviews \
	hvplot \
	param \
	&& conda clean -y --all

RUN pip install --no-cache \
	jupyterlab-drawio \
	lckr-jupyterlab-variableinspector \
	jupyterlab-system-monitor \
	jupyterlab-cell-flash \
	jupyterlab-tabular-data-editor \
	jupyterlab_autoversion \
	jupyterlab-interactive-dashboard-editor \
	jupyterlab-code-snippets \
	jupyterlab_executor \
	jupyterlab_hdf \
	hdf5plugin

RUN jupyter labextension install \
	@jupyterlab/hdf5 \
	&& jupyter lab clean \
	&& jlpm cache clean

RUN source activate py38 && pip install --no-cache papermill[all]

# for python-lsp-server:
RUN sed -i 's/# c.Completer.use_jedi = True/c.Completer.use_jedi = False/g' ~/.ipython/profile_default/ipython_config.py

# for jupyterlab-cell-flash, jupyterlab_execute_time and jupyterlab-executor:
COPY overrides.json /home/idies/miniconda3/share/jupyter/lab/settings/overrides.json

USER root

RUN dnf install -y htop csh tcsh && dnf clean all && rm -rf /var/cache/yum

# Start with Jupyterlab by default and update cpu entry in startup.sh for jupyterlab-system-monitor and hdf5 widget.
# Also, make startup file only executable and readable by group
COPY startup.sh /opt/startup.sh
RUN chgrp idies /opt/startup.sh && chmod 0755 /opt/startup.sh

USER idies

