FROM debian:latest
MAINTAINER Ankit R Gadiya <me@argp.in>

# Installation 
RUN apt-get update \
	&& apt-get install -y \
		python \
		build-essential \
		libssl-dev \
		apache2-utils \
		libxml2-dev \
		git \
		curl \
		locales \
		tmux \
	&& sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
	&& locale-gen \
	&& git clone https://github.com/creationix/nvm.git ~/.nvm \
	&& bash -c "source ~/.nvm/nvm.sh && nvm install 0.10;" \
	&& git clone https://github.com/c9/core.git ~/c9sdk \
	&& rm -rf ~/c9sdk/.git \
	&& cd ~/c9sdk \
	&& ./scripts/install-sdk.sh \
	&& apt-get remove build-essential -y \
	&& apt-get autoremove -y

# Script
COPY init.sh ~/.init.sh

# Server
EXPOSE 3000
CMD ["bash", "~/.init.sh"]
