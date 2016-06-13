defmodule Pagarmex.Mixfile do
  use Mix.Project

  def version, do: "0.0.1"

  def project do
    [
      app:               :pagarmex,
      version:           version,
      description:       description,
      package:           package,
      elixir:            "~> 1.2",
      build_embedded:    Mix.env == :prod,
      start_permanent:   Mix.env == :prod,
      deps:              deps(Mix.env),
     ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps(_) do
    [
    ]
  end

  defp description do
    """
    A PagarMe Library for Elixir.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Gullit Miranda <gullitmiranda@gmail.com>"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/gullitmiranda/pagarmex",
        "Docs"   => "https://hexdocs.pm/pagarmex"
      }
    ]
  end

end
