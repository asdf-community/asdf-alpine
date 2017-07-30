FROM vborja/asdf-alpine:nodejs-8.2.1 as nodejs

FROM vborja/asdf-alpine:elixir-1.5.0-otp-20
COPY --from=nodejs /asdf/.asdf/plugins/nodejs /asdf/.asdf/plugins/
COPY --from=nodejs /asdf/.asdf/installs/nodejs /asdf/.asdf/installs

