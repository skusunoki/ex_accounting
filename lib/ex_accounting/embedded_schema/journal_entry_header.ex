defmodule ExAccounting.EmbeddedSchema.JournalEntryHeader do
  @moduledoc """
  Journal Entry Header
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          accounting_unit: ExAccounting.Elem.AccountingUnit.t(),
          document_date: ExAccounting.Elem.DocumentDate.t(),
          posting_date: ExAccounting.Elem.PostingDate.t(),
          accounting_document_number: ExAccounting.Elem.AccountingDocumentNumber.t(),
          accounting_unit: ExAccounting.EmbeddedSchema.AccountingUnit.t()
        }

  embedded_schema do
    field(:accounting_unit, ExAccounting.Elem.AccountingUnit)
    field(:document_date, ExAccounting.Elem.DocumentDate)
    field(:posting_date, ExAccounting.Elem.PostingDate)
    field(:accounting_document_number, ExAccounting.Elem.AccountingDocumentNumber)
    field(:transaction_currency, ExAccounting.Elem.TransactionCurrency)
    embeds_one(:accounting_unit_attr, ExAccounting.EmbeddedSchema.AccountingUnit)
  end

  @spec changeset(t, map) :: Ecto.Changeset.t()
  def changeset(journal_entry_header, params) do
    params_comp =
      case Map.has_key?(params, :accouting_unit_attr) do
        false ->
          params
          |> Map.put(:accounting_unit_attr, %{} |> Map.put(:accounting_unit, params.accounting_unit))

        _ ->
          params
      end

    journal_entry_header
    |> cast(params_comp, [
      :accounting_unit,
      :document_date,
      :posting_date,
      :transaction_currency
    ])
    |> validate_required([
      :accounting_unit,
      :document_date,
      :posting_date,
      :transaction_currency
    ])
    |> validate_inclusion(:accounting_document_number, [nil])
    |> validate_exclusion(:transaction_currency, [nil])
    |> cast_embed(:accounting_unit_attr,
      with: &ExAccounting.EmbeddedSchema.AccountingUnit.changeset/2
    )
  end
end
