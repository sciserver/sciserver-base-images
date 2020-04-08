FROM sciserver-essentials:1.1

USER root 

RUN yum -y install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm \
	&& yum -y install ffmpeg ffmpeg-devel

USER idies

COPY --chown=idies:idies environment_Oceanography.yml /home/idies/environment_Oceanography.yml

RUN (source activate py37 \
	&& conda install conda-build \
	&& conda update conda \
	&& conda update conda-build \
	&& conda env create -f /home/idies/environment_Oceanography.yml \
	&& conda clean -y --all)

RUN (source activate Oceanography \
	&& conda install ipykernel \
	&& python -m ipykernel install --user --name Oceanography --display-name "Oceanography")

RUN conda install nodejs \
	&& conda clean -y --all \
	&& pip install dask_labextension \
	&& jupyter labextension install dask-labextension \
	&& jupyter serverextension enable --py --sys-prefix dask_labextension


# Install Julia

COPY --chown=idies:idies julia-setup.jl /home/idies/

RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.0-linux-x86_64.tar.gz \
	&& tar -xzvf julia-1.4.0-linux-x86_64.tar.gz \
	&& rm -f julia-1.4.0-linux-x86_64.tar.gz

USER root

RUN ln -s /home/idies/julia-1.4.0/bin/julia /usr/local/bin/julia

USER idies

RUN julia /home/idies/julia-setup.jl


# Install nginx

USER root

RUN yum -y install nginx
COPY startup.sh /opt/startup.sh
COPY nginx.conf /etc/nginx/nginx.conf
