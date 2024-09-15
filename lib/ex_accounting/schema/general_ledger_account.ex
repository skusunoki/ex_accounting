defmodule ExAccounting.Schema.GeneralLedgerAccount do
  use Ecto.Schema

  schema "general_ledger_accounts" do
    field(:general_ledger_account, ExAccounting.Elem.GeneralLedgerAccount)
    field(:general_ledger_account_type, :string)
    field(:general_ledger_account_short_name, :string)
    field(:general_ledger_account_long_name, :string)
  end
end
