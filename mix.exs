defmodule StandingsPoller.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      dialyzer: [
        flags: ["-Wunmatched_returns", :error_handling, :underspecs]
      ],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.travis": :test,
        inch: :test,
        "inch.report": :test,
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
      {:ex_doc, "~> 0.19.0", only: :dev, runtime: false},
      {:inch_ex, "~> 2.0.0-dev", only: [:test], github: "rrrene/inch_ex"},
      {:credo, "~> 0.9", only: [:dev, :test]},
      {:dialyxir, "~> 1.0.0-rc.3", only: [:dev], runtime: false},
      {:excoveralls, "~> 0.8", only: :test}
    ]
  end
end
