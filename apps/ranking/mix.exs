defmodule Ranking.MixProject do
  use Mix.Project

  def project do
    [
      app: :ranking,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :eex, :public_key],
      mod: {Ranking.Application, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:exvcr, "~> 0.10", only: :test},
      {:jason, "~> 1.1"},
      {:persistence, in_umbrella: true},
      {:decimal, "~> 1.0"},
      {:dataloader, "~> 1.0.4"}
    ]
  end
end
