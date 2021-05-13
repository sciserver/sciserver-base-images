FROM sciserver-essentials:2.2

RUN mamba install -y -n py38 -c conda-forge \
        jupyter_bokeh \
        jupyter-dash \
        jupyter-server-proxy \
        voila \
        jupyterlab_code_formatter \
        black \
        isort \
        itkwidgets \
        ipympl \
        mamba_gator \
        jupyterlab-spellchecker \
        jupyterlab-git

RUN mamba install -y -n py38 -c pyviz panel holoviews

RUN pip install \
        jupyterlab-drawio \
        lckr-jupyterlab-variableinspector \
        jupyterlab-system-monitor \
        jupyterlab-cell-flash \
        jupyterlab-tabular-data-editor

USER root
# update cpu entry in startup.sh for jupyterlab-system-monitor
# make stratup file only executable and readable by group
COPY startup.sh /opt/startup.sh
RUN chgrp idies /opt/startup.sh && chmod 0755 /opt/startup.sh
USER idies