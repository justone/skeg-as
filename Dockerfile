FROM skegio/clojure:java8

# Neovim and Vim 8.x
RUN apt-get update && apt-get install -y  && \
    add-apt-repository ppa:jonathonf/vim && \
    add-apt-repository ppa:neovim-ppa/unstable && \
    apt-get update && apt-get install -y vim-nox neovim python-dev python-pip python3-dev python3-pip && \
    pip install neovim && \
    pip3 install neovim

# need the JDK variant for real Java compiles
RUN apt update && apt install -y openjdk-8-jdk-headless
