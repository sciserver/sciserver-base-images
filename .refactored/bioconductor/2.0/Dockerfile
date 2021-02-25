FROM sciserver-rstudio:2.0

USER idies

WORKDIR /home/idies

RUN Rscript -e "install.packages('BiocManager', Ncpus=`nproc`); BiocManager::install(version = "3.12")" \
        && Rscript -e "BiocManager::install(c( 'gplots', 'reticulate', 'rtracklayer', 'bumphunter', 'RTopper', 'Homo.sapiens', 'reactome.db', 'MOFA', 'MOFAdata', 'vqv/ggb
iplot' ), Ncpus=`nproc`)"

RUN python -m venv /home/idies/env-mofa \
        && Rscript -e "reticulate::virtualenv_install( '/home/idies/env-mofa', 'mofapy' )"

USER root
