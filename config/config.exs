import Config

config :ex_accounting, ExAccounting.Repo,
  database: "ex_accounting_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :ex_accounting, ecto_repos: [ExAccounting.Repo]
