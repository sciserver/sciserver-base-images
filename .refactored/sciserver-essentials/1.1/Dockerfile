FROM sciserver-essentials:1.0

# Ensure matplotlib inline rendering by default

RUN ipython profile create \
	&& printf "\nc.InteractiveShellApp.matplotlib = 'inline'\n" >> /home/idies/.ipython/profile_default/ipython_kernel_config.py
