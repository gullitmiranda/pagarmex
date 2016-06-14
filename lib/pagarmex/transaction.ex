defmodule Pagarmex.Transaction do
  alias Pagarmex.{
    Card,
    Client
  }

  defstruct status:                 nil,
            refuse_reason:          nil,
            status_reason:          nil,
            acquirer_response_code: nil,
            authorization_code:     nil,
            soft_descriptor:        nil,
            tid:                    nil,
            nsu:                    nil,
            date_created:           nil,
            date_updated:           nil,
            amount:                 nil,
            installments:           nil,
            id:                     nil,
            cost:                   nil,
            postback_url:           nil,
            payment_method:         nil,
            antifraud_score:        nil,
            boleto_url:             nil,
            boleto_barcode:         nil,
            boleto_expiration_date: nil,
            referer:                nil,
            ip:                     nil,
            subscription_id:        nil,
            card:                   nil,
            phone:                  nil,
            address:                nil,
            customer:               nil,
            metadata:               nil


  @type t :: %__MODULE__{
    status:                 String.t,
    refuse_reason:          String.t,
    status_reason:          String.t,
    acquirer_response_code: String.t,
    authorization_code:     String.t,
    soft_descriptor:        String.t,
    tid:                    String.t,
    nsu:                    String.t,
    date_created:           String.t,
    date_updated:           String.t,
    amount:                 number,
    installments:           number,
    id:                     number,
    cost:                   number,
    postback_url:           String.t,
    payment_method:         String.t,
    antifraud_score:        String.t,
    boleto_url:             String.t,
    boleto_barcode:         String.t,
    boleto_expiration_date: String.t,
    referer:                String.t,
    ip:                     String.t,
    subscription_id:        number,
    card:                   Card.t,
    phone:                  Map.t,
    address:                Map.t,
    customer:               Map.t,
    metadata:               Map.t,
  }

  def endpoint, do: "transactions"

  def create(%{} = params) do
    Client.send(:post, endpoint, params)
    |> Client.handle_response
    |> Client.to_struct(%__MODULE__{})
    |> struct_references
  end

  def struct_references({:ok, transaction}) do
    transaction = transaction
    |> Map.update!(:card, fn(card) -> struct(%Card{}, card || %{}) end)

    {:ok, transaction}
  end

  def struct_references({:error, _} = response), do: response
end
