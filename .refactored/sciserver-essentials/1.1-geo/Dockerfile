FROM sciserver-essentials:1.1

RUN conda install -n py37 -y \
		cartopy \
		descartes \
		geopandas \
		geos \
		libspatialindex \
		pysal \
		rtree \
		ipywidgets \
		plotly \
		dash \
	&& conda install -n py37 -y -c gurobi \
		gurobi \
	&& conda install -n py37 -y -c conda-forge \
		geopy \
		osmnx \
		geoplot \
	&& (source activate py37 && pip install --no-cache-dir \
		GeobricksProj4ToEPSG \
		jsonpath-rw-ext \
		census \
		us \
		censusgeocode) \
	&& conda clean -y --all
