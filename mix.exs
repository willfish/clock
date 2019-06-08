defmodule Clock.MixProject do
  use Mix.Project

  def project do
    [
      app: :clock,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Clock, []}
    ]
  end

  defp deps do
    [
      {:distillery, "~> 2.0.0"}
    ]
  end
end
