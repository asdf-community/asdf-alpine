FROM alpine:latest

LABEL maintainer="Victor Borja <vborja@apache.org>"

RUN apk add --virtual .asdf-deps --no-cache bash curl git 
SHELL ["/bin/bash", "-l", "-c"]
RUN adduser -s /bin/bash -D asdf

USER asdf
RUN git clone --depth 1 https://github.com/asdf-vm/asdf.git ~/.asdf && \
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc && \
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.profile && \
    source ~/.bashrc

USER root