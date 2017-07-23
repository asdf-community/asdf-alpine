FROM vborja/asdf-alpine:latest

COPY erlang/ .asdf/toolset/

USER root
RUN  bash .asdf/toolset/erlang/build-deps
USER asdf
RUN  asdf-install-toolset erlang

