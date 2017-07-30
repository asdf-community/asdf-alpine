FROM vborja/asdf-alpine:erlang-20.0

RUN asdf update --head
ADD elixir .asdf/toolset/elixir/
RUN asdf-install-toolset elixir
