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
      preferred_cli_env: [
        vcr:          :test,
        "vcr.delete": :test,
        "vcr.check":  :test,
        "vcr.show":   :test,
      ],
     ]
  end

  def application do
    [applications: [:httpoison]]
  end

  defp deps(_) do
    [
      {:httpoison, "~> 0.8.3"},
      {:poison, "~> 2.1"},
      {:ex_doc, "~> 0.11.5", only: :dev},
      {:earmark, "~> 0.2.1", only: :dev},
      {:exvcr, "~> 0.7.4", only: :test},
      {:mock, "~> 0.1.3", only: :test},
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
