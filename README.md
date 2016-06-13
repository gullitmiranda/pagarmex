# PagarMe for Elixir

An Elixir library to make payments in [PagarMe](https://pagar.me).

## Features

- Create Card
- Make Payment using credit card

## Installation

If [available in Hex](https://hex.pm/packages/pagarmex), the package can be installed as:

##### Add `:pagarmex` to your list of dependencies in `mix.exs`:

```ex
def deps do
  [{:pagarmex, "~> 0.0.1"}]
end
```

##### Ensure pagarmex is started before your application:

```ex
def application do
  [applications: [:pagarmex]]
end
```

##### Adding config:

```ex
use Mix.Config

config :pagamex, api_key: System.get_env("PAGARME_API_KEY")
                # optional
                # endpoint: 'https://api.pagar.me/1'
```

## DOCS

Access http://hexdocs.pm/pagarmex to full documentation.

## Test

Getting your `PAGARME_API_KEY` in ( https://dashboard.pagar.me/#/myaccount/apikeys ) and adding to `.env` file, :

```sh
echo "PAGARME_API_KEY=value" >> .env
```

run tests

```sh
make test
```

# Contributing

1. Fork it ( https://github.com/gullitmiranda/pagarmex/fork )
2. Create your feature branch (git checkout -b feature/new_feature_name)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin feature/new_feature_name)
5. Create a new Pull Request
