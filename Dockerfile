FROM azukiapp/elixir:1.2

# install erlang-tools and update hex
RUN  apk add --update \
    erlang-tools@community --force \
  && mix local.hex --force \
  && rm -rf /var/cache/apk/* /var/tmp/*

CMD ["iex"]
