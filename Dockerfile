FROM vborja/asdf-alpine:node-8.2.1 as nodejs

FROM vborja/asdf-alpine:elixir-1.5.0-otp-20
COPY --from=nodejs $HOME/.asdf/plugins/nodejs $HOME/.asdf/plugins/
COPY --from=nodejs $HOME/.asdf/installs/nodejs $HOME/.asdf/installs

