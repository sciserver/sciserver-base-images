FROM bioconductor:2.0

USER idies

WORKDIR /home/idies

RUN Rscript -e "BiocManager::install('DESeq2')"

RUN Rscript -e "install.packages('learnr')"

USER root
