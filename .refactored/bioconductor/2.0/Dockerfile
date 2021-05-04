FROM sciserver-rstudio:2.0

USER idies

WORKDIR /home/idies

RUN Rscript -e "install.packages('BiocManager', Ncpus=`nproc`); BiocManager::install(version = "3.12")"

USER root
