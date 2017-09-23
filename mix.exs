defmodule Cabify.Mixfile do
  use Mix.Project

  def project do
    [
      app: :cabify,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:poison, "~> 3.1"}
    ]
  end
end
