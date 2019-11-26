FROM sciserver-jupyter

USER idies

COPY julia-setup.jl /home/idies/

RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.2/julia-1.2.0-linux-x86_64.tar.gz \
  && tar -xzvf julia-1.2.0-linux-x86_64.tar.gz \
  && rm -f julia-1.2.0-linux-x86_64.tar.gz

USER root
RUN ln -s /home/idies/julia-1.2.0/bin/julia /usr/local/bin/julia

USER idies
RUN julia /home/idies/julia-setup.jl


### Added for compatibility with SciServer
USER root
RUN cp /etc/entrypoint.sh /opt/startup.sh
ENTRYPOINT []
USER idies
