FROM dockerregistry:443/sciserver-jupyter:2.0

# Python (Anaconda)

RUN conda create -y --name py38 python=3.8 anaconda=2020.11 \
	&& conda clean -y --all \
	&& source activate py38 \
	&& python -m ipykernel install --user --name py38 --display-name "Python 3.8 (py38)" \
	&& /bin/bash -c 'printf "source activate py38\n" >> ~/.bashrc'


# R

USER root

RUN yum -y install epel-release \
	&& yum config-manager --set-enabled PowerTools \
	&& yum -y install \
		gcc-gfortran \
		zeromq-devel \
		zlib-devel \
		readline-devel \
		bzip2-devel \
		xz-devel \
		pcre-devel \
		openssl-devel \
		libcurl-devel \
		libpng-devel \
		libtiff-devel \
		libjpeg-devel \
		cairo-devel \
		libXt-devel \
		texinfo \
		pandoc \
		glibc-locale-source \
		glibc-langpack-en \
	&& yum clean all \
	&& rm -rf /var/cache/yum

USER idies

ARG R_VERSION=4.0.3

RUN curl -L https://cran.rstudio.com/src/base/R-4/R-$R_VERSION.tar.gz -o R.tar.gz \
	&& tar -xzf R.tar.gz \
	&& cd R-$R_VERSION \
	&& ./configure --prefix=/home/idies/R --enable-R-shlib --with-x=no \
	&& make -j`nproc` \
	&& make install \
	&& cd .. \
	&& rm -rf R.tar.gz R-$R_VERSION

ENV PATH /home/idies/R/bin:$PATH

RUN Rscript -e "install.packages(c('Cairo', 'IRkernel'), repos='https://cloud.r-project.org/')" \
	&& Rscript -e "IRkernel::installspec(displayname = 'R $R_VERSION')" \
	&& /bin/bash -c $'printf "options(bitmapType=\'cairo\')\n" >> ~/.Rprofile'


# SciScript Python

RUN conda install -n py38 -y \
		argcomplete \
		chest \
		configobj \
		dill \
		redis \
		redis-py \
		sphinx_rtd_theme \
		traceback2 \
		unittest2 \
	&& conda install -n py38 -y -c conda-forge \
		grequests \
	&& conda clean -y --all

RUN git clone https://github.com/sciserver/SciScript-Python.git \
	&& touch /home/idies/keystone.token \
	&& cd /home/idies/SciScript-Python \
	&& git checkout sciserver-v2.0.13 \
	&& cd py3 \
	&& (source activate py38 && python setup.py install) \
	&& rm /home/idies/keystone.token


# SciScript R

RUN Rscript -e "install.packages(c('bit64', 'jpeg', 'httr', 'jsonlite', 'data.table'), repos='https://cloud.r-project.org/')"

RUN git clone https://github.com/sciserver/SciScript-R.git \
	&& touch /home/idies/keystone.token \
	&& cd /home/idies/SciScript-R \
	&& git checkout sciserver-v2.0.13 \
	&& cd .. \
	&& R CMD build SciScript-R \
	&& R CMD INSTALL SciServer*.tar.gz \
	&& rm -rf /home/idies/SciServer*.tar.gz \
	&& rm /home/idies/keystone.token


# Mamba (fast package manager)

RUN conda install -y -c conda-forge mamba \
        && conda clean -y --all


# Tensorflow

RUN mamba install -n py38 -y tensorflow==2.3.0 \
	&& conda clean -y --all


# Link to JupyterLab

COPY --chown=idies lab_extension /home/idies/lab_extension

RUN jupyter nbextension install /home/idies/lab_extension --user \
	&& jupyter nbextension enable lab_extension/main --user --section='common'


# Ensure matplotlib inline rendering by default

RUN ipython profile create \
	&& printf "\nc.InteractiveShellApp.matplotlib = 'inline'\n" >> /home/idies/.ipython/profile_default/ipython_kernel_config.py


# Plotly

RUN mamba install -y -c conda-forge plotly \
	&& mamba install -n py38 -y -c conda-forge plotly \
	&& conda clean -y --all


# Geo

RUN mamba install -n py38 -y -c conda-forge \
		geopy \
		osmnx \
		geoplot \
		cartopy \
		pyepsg \
		descartes \
		geos \
		libspatialindex \
		libiconv \
		geopandas \
		pysal \
		rtree \
	&& (source activate py38 && pip install --no-cache-dir \
		GeobricksProj4ToEPSG \
		jsonpath-rw-ext \
		census \
		us \
		censusgeocode) \
	&& conda clean -y --all

USER root
RUN yum -y install libnsl.so.1 && ln -s /usr/lib64/libnsl.so.2 /usr/lib64/libnsl.so.1
USER idies


# PyTorch

RUN source activate py38 && pip install --no-cache-dir torch==1.7.1+cpu torchvision==0.8.2+cpu torchaudio===0.7.2 -f https://download.pytorch.org/whl/torch_stable.html
RUN mamba install -n py38 -y -c conda-forge libuv ninja \
	&& conda clean -y --all


# NodeJS

USER root
RUN yum -y install nodejs
USER idies


RUN jupyter labextension install jupyterlab-plotly@4.14.1 \
	&& jupyter labextension install @jupyter-widgets/jupyterlab-manager plotlywidget@4.14.1 \
	&& jupyter lab clean \
	&& jlpm cache clean


# ipyleaflet

RUN mamba install -y -c conda-forge ipyleaflet \
	&& mamba install -n py38 -y -c conda-forge ipyleaflet \
	&& conda clean -y --all
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-leaflet \
	&& jupyter lab clean \
	&& jlpm cache clean


# Latest numpy and scipy

RUN mamba install -n py38 -y -c conda-forge numpy==1.19.4 scipy==1.6.0 \
	&& conda clean -y --all
