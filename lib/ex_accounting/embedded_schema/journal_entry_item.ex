defmodule ExAccounting.EmbeddedSchema.JournalEntryItem do
  @moduledoc """
  Journal Entry Item
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          item_number: ExAccounting.Elem.AccountingDocumentItemNumber.t(),
          general_ledger_transaction: ExAccounting.EmbeddedSchema.GeneralLedgerTransaction.t()
        }
  embedded_schema do
    field(:item_number, ExAccounting.Elem.AccountingDocumentItemNumber)
    embeds_one(:general_ledger_transaction, ExAccounting.EmbeddedSchema.GeneralLedgerTransaction)
  end

  def changeset(journal_entry_item, params) do
    journal_entry_item
    |> cast(params, [:item_number])
    |> validate_required([:item_number])
    |> cast_embed(:general_ledger_transaction,
      with: &ExAccounting.EmbeddedSchema.GeneralLedgerTransaction.changeset/2
    )
  end
end
