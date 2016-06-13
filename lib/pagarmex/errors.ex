defmodule Pagarmex.MissingApiKeyError do
  defexception message: """
    Te `api_key` is required. Please adding `api_key` in your `config.exs`.
    config :pagamex, api_key: System.get_env("PAGARME_API_KEY")

    More info in: https://github.com/gullitmiranda/pagarmex#installation .
  """
end
