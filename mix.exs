defmodule ExAccounting.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_accounting,
      version: "0.1.0",
      elixir: "~> 1.17-rc",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Docs
      name: "ExAccounting",
      source_url: "https://github.com/skusunoki/ex_accounting",
      docs: [
        main: "readme",
        extras: ["README.md", "CHANGELOG.md"],
        groups_for_modules: [
          journal_entry: ~r"JournalEntry",
          current_status: ~r"CurrentStatus",
          elem: ~r"Elem",
          configuration: ~r"Configuration",
          system_dictionary: ~r"SystemDictionary"
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExAccounting.Application, []},
      registered: [
        ExAccounting.Repo,
        ExAccounting.Configuration.CurrencyConfiguration.Server,
        ExAccounting.Configuration.AccountingDocumentNumberRange.Server,
        ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber.Server
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
