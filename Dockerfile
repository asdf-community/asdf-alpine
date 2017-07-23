FROM vborja/asdf-alpine:latest

ADD erlang .asdf/toolset/erlang/

USER root
RUN  bash .asdf/toolset/erlang/build-deps
USER asdf
RUN  asdf-install-toolset erlang

