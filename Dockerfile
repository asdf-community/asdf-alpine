FROM vborja/asdf-alpine:latest

COPY erlang/ .asdf-toolset/

USER root
RUN  asdf-install-toolset-deps erlang
USER asdf
RUN  asdf-install-toolset erlang

