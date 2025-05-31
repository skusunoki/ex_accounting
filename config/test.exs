# Test configuration for ExAccounting
import Config

# Configure the test database
config :ex_accounting, ExAccounting.Repo,
  database: "ex_accounting_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# Print only warnings and errors during test runs
config :logger, level: :warn

# Configure ExUnit
config :ex_unit,
  exclude: [:performance, :integration],
  formatters: [ExUnit.CLIFormatter],
  colors: [enabled: true]

# Test-specific configurations
config :ex_accounting,
  # Disable certain background processes during testing
  start_servers: false,
  
  # Test currency configuration
  default_currency: "USD",
  test_accounting_area: "0001",
  test_accounting_unit: "1000"