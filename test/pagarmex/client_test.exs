defmodule Pagarmex.ClientTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start
  end

  alias Pagarmex.Client

  @base    Pagarmex.endpoint
  @api_key Pagarmex.api_key

  test "check endpoint" do
    assert Client.api_url             == @base
    assert Client.api_url(nil)        == @base
    assert Client.api_url("cards")    == Client.api_url <> "/cards"
    assert Client.api_url("cards/id") == Client.api_url <> "/cards/id"
  end

  test "check endpoint with custom query" do
    api_key = Client.api_key
    assert Client.api_url("cards"    , %{key: "value"})     == Client.api_url <> "/cards?key=value"
    assert Client.api_url("cards?a=1", %{key: "value"})     == Client.api_url <> "/cards?a=1&key=value"
    assert Client.api_url("cards"    , %{api_key: api_key}) == Client.api_url <> "/cards?api_key=" <> Client.api_key
  end

  test "should success response" do
    use_cassette "balance_get" do
      response = Client.send(:get, "balance")
      |> Client.decode_body

      assert response["object"] == "balance"
    end
  end

end
