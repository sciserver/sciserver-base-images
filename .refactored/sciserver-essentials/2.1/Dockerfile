FROM dockerregistry:443/sciserver-essentials:2.0

RUN mamba update -y -n base -c conda-forge jupyterlab=3.0.8 \
		&& mamba install -y -n py38 -c conda-forge hdf5 netcdf4 zarr xarray \
		&& conda clean -y -a

USER root
RUN dnf -y remove nodejs \
		&& dnf -y module reset nodejs \
		&& dnf -y module install nodejs:14 \
		&& dnf clean all \
		&& rm -rf /var/cache/yum
USER idies

RUN mamba update -y -c conda-forge plotly ipyleaflet \
		&& mamba update -y -n py38 -c conda-forge plotly ipyleaflet \
		&& conda clean -y -a

RUN jupyter labextension install jupyterlab-plotly@4.14.3 \
		&& jupyter labextension install @jupyter-widgets/jupyterlab-manager plotlywidget@4.14.3 \
		&& jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-leaflet \
		&& jupyter lab clean \
		&& jlpm cache clean

RUN source activate py38 \
		&& cd SciScript-Python \
		&& git fetch \
		&& python Install.py sciserver-v2.1.0
