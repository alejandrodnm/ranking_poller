defmodule StandingsPoller.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.travis": :test,
        inch: :docs,
        "inch.report": :docs,
        vcr: :test,
        "vcr.delete": :test,
        "vcr.check": :test,
        "vcr.show": :test
      ]
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      # Docs dependencies
      {:ex_doc, "~> 0.18.0", only: :docs, runtime: false},
      {:inch_ex, "~> 0.5", only: [:docs]},
      {:credo, "~> 0.9", only: [:dev, :test]},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.8", only: :test}
    ]
  end
end
