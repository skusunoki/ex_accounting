defmodule ExAccounting.EmbeddedSchema.GeneralLedgerTransaction.Impl do
  @moduledoc false

  import Ecto.Changeset

  def changeset(general_ledger_transaction, params) do
    general_ledger_transaction
    |> cast(params, [:general_ledger_account, :general_leadger_transaction_type, :debit_credit])
    |> validate_inclusion(:general_ledger_transaction_type, [:opening_balance, :debit_posting, :credit_posting])
    |> validate_inclusion(:debit_credit, [:debit, :credit])
#TODO
  end

end
