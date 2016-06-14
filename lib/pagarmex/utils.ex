defmodule Pagarmex.Utils do

  @doc """
  Convert all keys from string to atom in Map

      iex> string_map_to_atoms(%{"key" => "value"})
      %{key: "value"}
  """
  def to_atom(term) when is_atom(term), do: term
  def to_atom(term) when is_binary(term), do: term |> String.to_atom
  def to_atom(term) when is_list(term), do: term |> List.to_atom
  def to_atom(term), do: term

  def string_map_to_atoms(%{} = map) do
    map |> Enum.reduce(%{}, fn ({key, val}, acc) ->
      val = cond do
        Enumerable.impl_for(val) -> string_map_to_atoms(val)
        true -> val
      end
      Map.put(acc, to_atom(key), val)
    end)
  end

end
