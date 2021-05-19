FROM sciserver-essentials:2.2

RUN mamba install -y -n base  -c conda-forge \
        jupyter-server-proxy \
        jupyterlab_code_formatter \
        black \
        isort \
        mamba_gator \
        jupyterlab-spellchecker \
        jupyterlab-git \
        ipympl \
        && conda clean -y --all

RUN mamba install -y -n py38 -c conda-forge \
        jupyter_bokeh \
        jupyter-dash \
        voila \
        && conda clean -y --all

RUN mamba install -y -n py38 -c pyviz panel holoviews datashader geoviews hvplot param && conda clean -y --all

RUN pip install --no-cache \
        jupyterlab-drawio \
        lckr-jupyterlab-variableinspector \
        jupyterlab-system-monitor \
        jupyterlab-cell-flash \
        jupyterlab-tabular-data-editor

USER root

# update cpu entry in startup.sh for jupyterlab-system-monitor; make startup file only executable and readable by group
COPY startup.sh /opt/startup.sh

RUN chgrp idies /opt/startup.sh && chmod 0755 /opt/startup.sh

RUN yum install -y htop && yum clean all && rm -rf /var/cache/yum

USER idies