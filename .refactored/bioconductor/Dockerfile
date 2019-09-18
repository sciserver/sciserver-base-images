FROM sciserver-rstudio

RUN yum -y install python36-devel

USER idies

WORKDIR /home/idies

RUN Rscript -e "install.packages('tidyverse', Ncpus=`nproc`)"
RUN Rscript -e "install.packages('BiocManager', Ncpus=`nproc`)" \
	&& Rscript -e "BiocManager::install(c( 'gplots', 'reticulate', 'rtracklayer', 'bumphunter', 'RTopper', 'Homo.sapiens', 'reactome.db', 'MOFA', 'MOFAdata', 'vqv/ggbiplot' ), Ncpus=`nproc`)"

RUN python3 -m venv /home/idies/env-mofa \
	&& Rscript -e "reticulate::virtualenv_install( '/home/idies/env-mofa', 'mofapy' )"

USER root
