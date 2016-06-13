defmodule Pagarmex.Client do

  use HTTPoison.Base

  @doc """
  Set our request headers for every request.
  """
  def req_headers() do
    Map.new
      |> Map.put("User-Agent"  , "Pagarme/1 pagarmex/#{Pagarmex.version}")
      |> Map.put("Content-Type", "application/json")
  end

  alias Pagarmex.Utils

  def api_key do
    Pagarmex.api_key
  end

  def api_url(    ), do: api_url(""  , %{})
  def api_url(nil ), do: api_url(""  , %{})
  def api_url(path), do: api_url(path, %{})

  def api_url(%URI{} = uri, %{} = query) do
    case uri.host do
      nil ->
        base_uri = URI.parse(Pagarmex.endpoint)
        uri
        |> Map.put(:host  , base_uri.host)
        |> Map.put(:scheme, base_uri.scheme)
        |> Map.update!(:path, fn(path) ->
          join_path([base_uri.path, path])
        end)
      _ -> uri
    end
    |> add_query(query)
    |> URI.to_string
  end

  def api_url(path, query) when is_bitstring(path) do
    path
    |> URI.parse
    |> api_url(query)
  end

  def join_path(list) when is_list(list) do
    list
    |> Enum.filter(fn(v) -> not is_nil(v) end)
    |> Enum.reduce(fn(path, acc) ->
      Path.join(acc, path)
    end)
  end

  def add_query(%URI{} = uri, %{} = query) do
    case Enum.empty?(query) do
      true  ->
        uri
      false ->
        # stringify keys
        query = query
          |> Enum.map(fn({k, v}) -> {to_string(k), v} end)
          |> Enum.into(%{})

        uri
        |> Map.update!(:query, fn(uri_query) ->
          case uri_query do
            nil -> query
            _ ->
              uri_query
              |> URI.decode_query
              |> Map.merge(query)
          end |> URI.encode_query
        end)
    end
  end

  def send(method, endpoint, body \\ %{}, headers \\ %{}, options \\ []) do
    url = api_url(endpoint, %{api_key: api_key})

    body = body |> encode_body
    headers = req_headers
        |> Map.merge(headers)
        |> Map.to_list

    {:ok, response} = request(method, url, body, headers, options)
    response
  end

  def encode_body(%{} = body) do
    Poison.encode!(body)
  end

  def decode_body(%HTTPoison.Response{} = response) do
    decode_body(response.body)
  end

  def decode_body(body) do
    Poison.decode!(body)
  end

  def handle_response({:error, _} = reason), do: reason
  def handle_response({:ok, response}), do: handle_response(response)

  def handle_response(response) do
    body = decode_body(response)

    cond do
      body["errors"] -> {:error, body["errors"]}
      true -> {:ok, Utils.string_map_to_atoms(body)}
    end
  end

  def to_struct({:error, _} = response, _), do: response
  def to_struct({:ok, body}, struct_module) do
    case Map.has_key?(body, :object) do
      false -> {:error, body |> Map.put_new(:errors, [%{object: "invalid object type"}])}
      true -> {:ok, struct(struct_module, body)}
    end
  end

end
