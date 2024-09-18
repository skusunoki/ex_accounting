defmodule ExAccounting.EmbeddedSchema.GeneralLedgerTransaction do
  @moduledoc """
  _General Ledger Transaction_ is the transaction that is recorded in the general ledger.
  """
  use Ecto.Schema

  @primary_key false
  embedded_schema do
    field(:accounting_area, ExAccounting.Elem.AccountingArea)
    field(:accounting_unit, ExAccounting.Elem.AccountingUnit)
    field(:profit_center, ExAccounting.Elem.ProfitCenter)
    field(:fiscal_year, ExAccounting.Elem.FiscalYear)
    field(:accounting_period, ExAccounting.Elem.AccountingPeriod)
    field(:posting_date, ExAccounting.Elem.PostingDate)
    field(:general_ledger_account, :string)
    field(:general_leadger_transaction_type, :string)
    field(:debit_credit, :string)
    field(:accounting_document_number, ExAccounting.Elem.AccountingDocumentNumber)
    field(:accounting_document_item_number, ExAccounting.Elem.AccountingDocumentItemNumber)
    embeds_one(:transaction_value, ExAccounting.EmbeddedSchema.Money)
    embeds_one(:accounting_area_value, ExAccounting.EmbeddedSchema.Money)
    embeds_one(:accounting_unit_value, ExAccounting.EmbeddedSchema.Money)
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
