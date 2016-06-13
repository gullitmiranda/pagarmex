defmodule Pagarmex.Card do
  alias Pagarmex.Client

  defstruct id:              nil,
            holder_name:     nil,
            brand:           nil,
            country:         nil,
            first_digits:    nil,
            last_digits:     nil,
            fingerprint:     nil,
            valid:           nil,
            expiration_date: nil,
            customer:        nil,
            date_created:    nil,
            date_updated:    nil

  @type t :: %__MODULE__{
    id:              String.t,
    holder_name:     String.t,
    brand:           String.t,
    country:         String.t,
    first_digits:    String.t,
    last_digits:     String.t,
    fingerprint:     String.t,
    valid:           boolean,
    expiration_date: String.t,
    customer:        Map.t,
    date_created:    String.t,
    date_updated:    String.t,
  }

  def endpoint, do: "cards"

  def create(%{} = params) do
    Client.send(:post, endpoint, params)
    |> Client.handle_response
    |> Client.to_struct(%__MODULE__{})
  end
end


