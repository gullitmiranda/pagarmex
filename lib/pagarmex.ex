defmodule Pagarmex do
  @moduledoc """
  A PagarMe Library for Elixir.

  ### Configuration
  use Mix.Config

  config :pagarmex, api_key: System.get_env("PAGARME_API_KEY")
                  # optional
                  # endpoint: "https://api.pagar.me/1"
  """

  def version do
    Pagarmex.Mixfile.version
  end

  def api_key do
    case Application.get_env(:pagarmex, :api_key, System.get_env("PAGARME_API_KEY")) || :not_found do
      :not_found ->
        raise Pagarmex.MissingApiKeyError
      value -> value
    end
  end

  def endpoint do
    Application.get_env(:pagarmex, :endpoint) ||
    System.get_env("PAGARME_ENDPOINT") ||
    "https://api.pagar.me/1"
  end
end
