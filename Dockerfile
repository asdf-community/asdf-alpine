FROM vborja/asdf-alpine:elixir-1.5.0-otp-20

USER root
ADD https://github.com/vic/asdf-alpine/archive/nodejs-8.2.1.zip /tmp/nodejs.zip
RUN unzip /tmp/nodejs.zip -d /tmp
RUN mv /tmp/asdf-alpine-nodejs-8.2.1/nodejs .asdf/toolset/nodejs


USER root
RUN bash .asdf/toolset/nodejs/build-deps
USER asdf
RUN asdf-install-toolset nodejs
