defmodule ExAccounting.Repo do
  @moduledoc false

  use Ecto.Repo,
    otp_app: :ex_accounting,
    adapter: Ecto.Adapters.Postgres

end
