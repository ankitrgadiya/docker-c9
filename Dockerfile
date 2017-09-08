FROM debian:latest
MAINTAINER Ankit R Gadiya <me@argp.in>

# Install Packages
RUN apt-get update && apt-get install -y \
		python \
		make \
		g++ \
		build-essential \
		libssl-dev \
		apache2-utils \
		libxml2-dev \
		git \
		curl \
		locales \
		tmux

# Fix locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
		&& locale-gen

# Install node
RUN git clone https://github.com/creationix/nvm.git ~/.nvm
RUN bash -c "source ~/.nvm/nvm.sh && nvm install 0.10;"

# C9 Core
RUN git clone https://github.com/c9/core.git ~/c9sdk
RUN cd ~/c9sdk && ./scripts/install-sdk.sh

# Script
COPY init.sh ~/.init.sh

# Server
EXPOSE 3000
CMD ["bash", "~/.init.sh"]
