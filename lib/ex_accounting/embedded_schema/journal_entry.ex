defmodule ExAccounting.EmbeddedSchema.JournalEntry do
  @moduledoc """
  Journal Entry must have at least two transactions
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias ExAccounting.EmbeddedSchema.Money
  alias ExAccounting.Configuration

  @type t :: %__MODULE__{
          header: ExAccounting.EmbeddedSchema.JournalEntryHeader.t(),
          item: [ExAccounting.EmbeddedSchema.JournalEntryItem.t()]
        }
  embedded_schema do
    embeds_one(:header, ExAccounting.EmbeddedSchema.JournalEntryHeader)
    embeds_many(:item, ExAccounting.EmbeddedSchema.JournalEntryItem)
  end

  def changeset(journal_entry, params) do
    journal_entry
    |> cast(params, [])
    |> cast_embed(:header, with: &ExAccounting.EmbeddedSchema.JournalEntryHeader.changeset/2)
    |> cast_embed(:item, with: &ExAccounting.EmbeddedSchema.JournalEntryItem.changeset/2)
    |> validate_accounting_area_value()
    |> validate_transaction_value()
    |> determine_accounting_document_number()
  end

  def validate_accounting_area_value(changeset) do
    with journal_entry = apply_changes(changeset),
         total =
           journal_entry.item
           |> Enum.reduce(
             Money.new(
               Decimal.new("0"),
               Configuration.currency(journal_entry.header.accounting_unit_attr.accounting_area)
             ),
             fn item, acc ->
               case item.general_ledger_transaction.debit_credit.debit_credit do
                 :debit ->
                   Money.add(item.general_ledger_transaction.accounting_area_value, acc)

                 :credit ->
                   Money.add(
                     Money.negate(item.general_ledger_transaction.accounting_area_value),
                     acc
                   )
               end
             end
           ),
         true <-
           Money.is_equal?(
             total,
             Money.new(
               Decimal.new("0"),
               Configuration.currency(journal_entry.header.accounting_unit_attr.accounting_area)
             )
           ) do
      changeset
    else
      _ ->
        add_error(
          changeset,
          :completed_document,
          "Debit and credit amount of Accounting Area Currency must be same."
        )
    end
  end

  def validate_transaction_value(changeset) do
    with journal_entry = apply_changes(changeset),
         total =
           journal_entry.item
           |> Enum.reduce(
             Money.new(
               Decimal.new("0"),
               journal_entry.header.transaction_currency
             ),
             fn item, acc ->
               case item.general_ledger_transaction.debit_credit.debit_credit do
                 :debit ->
                   Money.add(item.general_ledger_transaction.transaction_value, acc)

                 :credit ->
                   Money.add(
                     Money.negate(item.general_ledger_transaction.transaction_value),
                     acc
                   )
               end
             end
           ),
         true <-
           Money.is_equal?(
             total,
             Money.new(
               Decimal.new("0"),
               journal_entry.header.transaction_currency
             )
           ) do
      changeset
    else
      error ->
        add_error(
          changeset,
          :completed_document,
          "Debit and credit amount of Transaction Currency must be same.",
          error: error
        )
    end
  end

  def determine_accounting_document_number(changeset) do
    with journal_entry = apply_changes(changeset),
         {:ok, issued} <- ExAccounting.State.Issueable.number(journal_entry) do
      changeset
      |> put_embed(:header, issued.header)
      |> put_embed(:item, issued.item)
    else
      _ -> changeset
    end
  end
end
