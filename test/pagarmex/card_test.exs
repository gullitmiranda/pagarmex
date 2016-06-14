defmodule Pagarmex.CardTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Pagarmex.{
    Card,
    Client
  }

  setup_all do
    HTTPoison.start
  end

  test "endpoint url" do
    url = Card.endpoint |> Client.api_url
    assert url =~ "/cards"
  end

  test "should valid card" do
    use_cassette "card_create" do
      # values generated by https://names.igopaygo.com/credit-card
      params = %{
        holder_name:     "Visa 1",
        card_number:     "5157702709932660",
        expiration_date: "0919",
      }
      {:ok, card} = Card.create(params)

      assert card.valid
      assert card.brand == "mastercard"
      assert params.holder_name == card.holder_name
    end
  end

  test "should invalid card" do
    use_cassette "card_create_invalid" do
      params = %{
        holder_name:     "no name",
        card_number:     "0000000000000000",
        expiration_date: "0000",
      }
      {:error, errors} = Card.create(params)
      first_error = errors |> hd |> Map.to_list

      assert {"type", "invalid_parameter"} in first_error
      assert {"parameter_name", "card_expiration_date"} in first_error
    end
  end

end
