FROM alpine:latest
ENV LANG="en_US.UTF-8" LANGUAGE="en_US:ja" LC_ALL="en_US.UTF-8"

# install neovim
RUN apk update && \
    apk add --update --no-cache --virtual .builddeps curl wget make unzip git\
            linux-headers musl-dev openssl-dev outils-md5 \
            pcre-dev cmake gcc g++ libtool automake autoconf libc-dev && \
    apk add --update --no-cache \
            python2-dev python3-dev gettext-dev \
            nodejs npm ruby-dev \
            lua5.1-dev perl-dev perl-utils && \
    wget https://luarocks.org/releases/luarocks-2.4.4.tar.gz && \
    tar zxpf luarocks-2.4.4.tar.gz && \
    cd luarocks-2.4.4 && \
    ./configure; make bootstrap && \
    luarocks build mpack && \
    luarocks build lpeg && \
    luarocks build inspect && \
    curl -kL https://bootstrap.pypa.io/pip/2.7/get-pip.py | python && \
    curl -kL https://bootstrap.pypa.io/get-pip.py | python3 && \
    python -m pip install pynvim && \
    python3 -m pip install pynvim neovim-remote && \
    npm install -g neovim && \
    gem install neovim && \
    git clone https://github.com/neovim/neovim.git -b nightly --depth 1 && \
    cd neovim && \
    make && \
    make install && \
    cd ../ && \
    rm -rf neovim && \
    rm /luarocks-2.4.4 -rf && \
    rm /luarocks-2.4.4.tar.gz && \
    apk del --purge .builddeps
