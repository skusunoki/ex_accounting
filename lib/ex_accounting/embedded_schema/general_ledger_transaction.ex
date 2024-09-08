defmodule ExAccounting.EmbeddedSchema.GeneralLedgerTransaction do
  @moduledoc """
  _General Ledger Transaction_ is the transaction that is recorded in the general ledger.
  """
  use Ecto.Schema

  @primary_key false
  embedded_schema do
    field(:general_ledger_account, :string)
    field(:general_leadger_transaction_type, :string)
  end

  def new(account, type) do
    %__MODULE__{
      general_ledger_account: account,
      general_leadger_transaction_type: type
    }
  end

  def reverse(%__MODULE__{} = transaction) do
    %__MODULE__{
      general_ledger_account: transaction.general_ledger_account,
      general_leadger_transaction_type: reverse(transaction.general_leadger_transaction_type)
    }
  end

  def reverse(type) do
    case type do
      :opening_balance -> :opening_balance
      :debit_posting -> :credit_posting
      :credit_posting -> :debit_posting
      _ -> :error
    end
  end
end
