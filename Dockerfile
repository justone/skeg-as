FROM skegio/clojure:java8

# Holen
RUN wget https://github.com/holen-app/holen/releases/download/v0.3.0/holen_linux_amd64 -O /usr/local/bin/holen && \
    chmod a+x /usr/local/bin/holen

# git annex
RUN wget -O- http://neuro.debian.net/lists/xenial.us-tn.full > /etc/apt/sources.list.d/neurodebian.sources.list && \
    apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9 && \
    apt-get update && apt-get install -y git-annex-standalone

# tmux
RUN add-apt-repository ppa:hnakamur/tmux && \
    apt-get update && apt-get install -y tmux

# Neovim and Vim 8.x
RUN add-apt-repository ppa:jonathonf/vim && \
    add-apt-repository ppa:neovim-ppa/unstable && \
    apt-get update && apt-get install -y vim-nox neovim python-dev python-pip python3-dev python3-pip && \
    pip install neovim && \
    pip3 install neovim

# need the JDK variant for real Java compiles
RUN apt update && apt install -y openjdk-8-jdk-headless visualvm

# protobuf compiler install
RUN wget https://github.com/google/protobuf/releases/download/v3.5.1/protoc-3.5.1-linux-x86_64.zip -O /tmp/protoc.zip && \
    unzip -d /usr/local /tmp/protoc.zip bin/protoc && \
    chmod a+x /usr/local/bin/protoc && \
    rm /tmp/protoc.zip

# node and yarn
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y nodejs yarn

# other apps
RUN apt-get update && apt-get install -y mongodb rsync graphviz bc

RUN echo "AddressFamily inet" >> /etc/ssh/sshd_config
