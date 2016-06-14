defmodule Pagarmex.TransactionTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Pagarmex.{
    Card,
    Client,
    Transaction,
  }

  setup_all do
    HTTPoison.start

    {:ok, card} = Card.create(%{
      holder_name:     "MasterCard - Chase Manhattan Bank USA, USA",
      card_number:     "5323 5537 5634 3734",
      expiration_date: "0218",
      cvv:             "768",
    })

    {:ok, %{card: card}}
  end

  test "endpoint url" do
    url = Transaction.endpoint |> Client.api_url
    assert url =~ "/transactions"
  end

  test "should valid transaction", %{card: card} do
    use_cassette "transaction_create" do
      params = %{
        card_id: card.id,
        amount:  123400,
      }
      {:ok, transaction} = Transaction.create(params)

      assert transaction.status == "paid"
      assert transaction.amount == 123400
      assert transaction.card == card
    end
  end

  test "should invalid transaction" do
    use_cassette "transaction_create_invalid" do
      params = %{
        card_id: nil,
        amount:  123400,
      }
      {:error, errors} = Transaction.create(params)
      first_error = errors |> hd |> Map.to_list

      assert {"type", "invalid_parameter"} in first_error
      assert {"parameter_name", "card_number"} in first_error
    end
  end

end
