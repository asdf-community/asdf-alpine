FROM alpine:latest

LABEL maintainer="Victor Borja <vborja@apache.org>"
LABEL updated_at=2017-07-23

RUN apk add --virtual .asdf-deps --no-cache bash curl git 
SHELL ["/bin/bash", "-l", "-c"]
RUN adduser -s /bin/bash -h /asdf -D asdf

ONBUILD USER asdf
ONBUILD WORKDIR /asdf
ONBUILD ADD .tool-deps .tool-repo .tool-versions /asdf/
ONBUILD RUN echo "DEPS: $(< ~asdf/.tool-deps)"
ONBUILD RUN echo "REPO: $(< ~asdf/.tool-repo)"

ONBUILD USER root
ONBUILD RUN apk add --virtual .asdf-tool-deps --no-cache $(cat ~asdf/.tool-deps)

ONBUILD USER asdf
ONBUILD RUN git clone --depth 1 https://github.com/asdf-vm/asdf.git $HOME/.asdf && \
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc && \
    echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.profile && \
    source ~/.bashrc

ONBUILD RUN cat $HOME/.tool-repo | while read i; do asdf plugin-add $(echo $i | cut -d\  -f1) $(echo $i | cut -d\  -f2-); done
ONBUILD RUN asdf install