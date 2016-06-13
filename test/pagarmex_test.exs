defmodule PagarmexTest do
  use ExUnit.Case
  doctest Pagarmex

  import Mock

  test "fails when the api_key is not defined" do
    with_mock System, [get_env: fn(_opts) -> nil end] do
      assert_raise Pagarmex.MissingApiKeyError, fn ->
        Pagarmex.api_key
      end
    end
  end

end
