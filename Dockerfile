FROM skegio/clojure:java8

# Holen
RUN wget https://github.com/holen-app/holen/releases/download/v0.3.0/holen_linux_amd64 -O /usr/local/bin/holen && \
    chmod a+x /usr/local/bin/holen

# git annex
RUN wget -O- http://neuro.debian.net/lists/xenial.us-tn.full > /etc/apt/sources.list.d/neurodebian.sources.list && \
    wget -O- http://neuro.debian.net/_static/neuro.debian.net.asc > /root/neuro.debian.key && \
    apt-key add /root/neuro.debian.key && rm /root/neuro.debian.key && \
    apt-get update && apt-get install -y git-annex-standalone

# Vim 8.x
RUN add-apt-repository ppa:jonathonf/vim && \
    apt-get update && apt-get install -y vim-nox

# Neovim
RUN apt-get update && apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip python-dev python-pip python3-dev python3-pip python3-venv && \
    wget https://github.com/neovim/neovim/archive/v0.4.3.tar.gz && \
    tar -xzvf v0.4.3.tar.gz && \
    cd neovim-0.4.3 && \
    make CMAKE_BUILD_TYPE=Release && \
    make install && \
    pip install neovim && \
    pip3 install neovim

# need visualvm
RUN apt update && apt install -y visualvm

# protobuf compiler install
RUN wget https://github.com/google/protobuf/releases/download/v3.5.1/protoc-3.5.1-linux-x86_64.zip -O /tmp/protoc.zip && \
    unzip -d /usr/local /tmp/protoc.zip bin/protoc && \
    chmod a+x /usr/local/bin/protoc && \
    rm /tmp/protoc.zip

# node and yarn
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y nodejs yarn

# other apps
RUN apt-get update && \
    apt-get install -y mongodb rsync graphviz bc telnet whois dnsutils netcat-openbsd && \
    npm install -g underscore-cli

RUN apt-get update && apt-get install libssl-dev g++ -y && \
    cd /root && git clone https://github.com/AGWA/git-crypt.git && cd git-crypt \
    make && make install && \
    cd .. && rm -rf git-crypt

# planck
RUN add-apt-repository ppa:mfikes/planck && \
    apt-get update && apt-get install -y planck

RUN echo "AddressFamily inet" >> /etc/ssh/sshd_config
