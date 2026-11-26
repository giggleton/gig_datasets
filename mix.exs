defmodule GigDatasets.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/giggleton/gig_datasets"

  def project do
    [
      app: :gig_datasets,
      version: @version,
      elixir: "~> 1.20",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      description:
        "Datasets to plot: copies of the tables R, ggplot2 and their packages ship, and map " <>
          "outlines, as plain data.",
      source_url: @source_url,
      package: package(),
      docs: [main: "GigDatasets", source_ref: "v#{@version}"]
    ]
  end

  # `mix quality` runs in test, the environment its `mix test` step needs.
  def cli do
    [preferred_envs: [quality: :test]]
  end

  def application do
    [extra_applications: []]
  end

  # Each dataset carries its source's licence, named in its file's header and its doc; the code is
  # MIT. A test checks this list against the files' headers.
  defp package do
    [
      licenses: ["MIT", "GPL-2.0-only", "GPL-2.0-or-later", "GPL-3.0-only"],
      links: %{"GitHub" => @source_url},
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
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.40", only: :dev, runtime: false}
    ]
  end

  # The commit gate: run bare before every commit; it stops at the first step that fails.
  defp aliases do
    [
      quality: [
        "format --check-formatted",
        "hex.audit",
        "compile --warnings-as-errors",
        "test --warnings-as-errors",
        "credo --strict"
      ]
    ]
  end
end
