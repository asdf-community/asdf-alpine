FROM vborja/asdf-alpine:erlang-19.3

ADD elixir .asdf/toolset/elixir/
RUN asdf-install-toolset elixir
