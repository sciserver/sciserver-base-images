FROM dockerregistry:443/oceanography:2.2

RUN (source activate base \
		&& conda install -y -c conda-forge mamba \
		&& conda clean -y --all)
		
RUN (source activate Oceanography \
        && mamba install -y -c conda-forge s3fs h5netcdf \
        && conda clean -y --all)
