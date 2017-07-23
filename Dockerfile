FROM alpine:latest

LABEL maintainer="Victor Borja <vborja@apache.org>"
LABEL updated_at=2017-07-23

RUN apk add --virtual .asdf-deps --no-cache bash curl git 
SHELL ["/bin/bash", "-l", "-c"]
RUN adduser -s /bin/bash -h /asdf -D asdf
ENV PATH="${PATH}:/asdf/.asdf/shims:/asdf/.asdf/bin"

USER asdf
WORKDIR /asdf

COPY asdf-install-plugins /usr/local/bin

ONBUILD USER asdf
ONBUILD RUN git clone --depth 1 https://github.com/asdf-vm/asdf.git $HOME/.asdf && \
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc && \
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.profile && \
    source ~/.bashrc

ONBUILD COPY .tool-* $HOME/

ONBUILD USER root
ONBUILD RUN bash ~asdf/.tool-deps

ONBUILD USER asdf
ONBUILD RUN asdf-install-plugins && source $HOME/.tool-setup-env && asdf install
