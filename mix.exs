defmodule GigDatasets.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :gig_datasets,
      version: @version,
      elixir: "~> 1.20",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description:
        "Datasets to plot: copies of the tables R, ggplot2 and their packages ship, as plain data.",
      package: package()
    ]
  end

  def application do
    [extra_applications: []]
  end

  # Each dataset carries its source's licence, named in its file's header and its doc; the code is
  # MIT. A test checks this list against the files' headers.
  defp package do
    [
      licenses: ["MIT", "GPL-2.0-only OR GPL-3.0-only", "GPL-2.0-or-later", "GPL-3.0-only"],
      files: [
        "lib",
        "priv",
        "mix.exs",
        "README.md",
        "LICENSE",
        "LICENSES",
        "THIRD_PARTY_NOTICES.md"
      ]
    ]
  end

  # NimbleCSV reads the files while the package compiles, and nothing calls it after.
  defp deps do
    [
      {:nimble_csv, "~> 1.3", runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end
end
