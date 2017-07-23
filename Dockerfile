FROM vborja/asdf-alpine:erlang-20.0

ADD elixir .asdf/toolset/elixir/
RUN asdf-install-toolset elixir
