defmodule Navii.Mixfile do
  use Mix.Project

  def project do
    [
      app: :navii,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [
      extra_applications: [:logger],
      mod: {Navii.Application, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:hedwig_irc, git: "git@github.com:ryanwinchester/hedwig_irc.git", branch: "debug"},
      {:hedwig_simple_responders, "~> 0.1.2"},
      {:distillery, "~> 1.4"},
      {:httpoison, "~> 0.11.2", override: true},
      {:hedwig_currency, "~> 0.1.0"},
      {:hedwig_weather, "~> 0.1.0"},
      {:hedwig_youtube, "~> 0.1.0"},
      {:hedwig_inspire, "~> 0.1.0"},
    ]
  end
end
