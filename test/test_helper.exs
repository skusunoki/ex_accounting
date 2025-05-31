ExUnit.start()

# Configure Ecto for testing
Application.put_env(:ex_accounting, ExAccounting.Repo,
  database: "ex_accounting_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10
)

# Start the repository for testing
{:ok, _} = ExAccounting.Repo.start_link()

# Set sandbox mode for concurrent testing
Ecto.Adapters.SQL.Sandbox.mode(ExAccounting.Repo, :manual)