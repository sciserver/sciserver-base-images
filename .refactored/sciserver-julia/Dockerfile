FROM sciserver-jupyter

USER idies

COPY julia-setup.jl /home/idies/

RUN conda install -y -c conda-forge julia=1.1.1 \
  && conda clean -y --all \
  && julia /home/idies/julia-setup.jl \
  && rm -rf /home/idies/.cache/


### Added for compatibility with SciServer
USER root
RUN cp /etc/entrypoint.sh /opt/startup.sh
ENTRYPOINT []
USER idies
