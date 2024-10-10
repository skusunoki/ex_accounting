defimpl ExAccounting.State.Issueable, for: ExAccounting.EmbeddedSchema.JournalEntry do
  alias ExAccounting.Configuration.AccountingDocumentNumberRangeDetermination
  alias ExAccounting.State.CurrentAccountingDocumentNumber

  @impl true
  def number(journal_entry) do
    with nil <- journal_entry.header.accounting_document_number,
         number =
           AccountingDocumentNumberRangeDetermination.determine(
             journal_entry.header.accounting_unit,
             journal_entry.header.document_type,
             journal_entry.header.fiscal_year
           )
           |> CurrentAccountingDocumentNumber.issue(),
         result = %{
           journal_entry
           | header: put_header(journal_entry.header, number),
             item: put_items(journal_entry.item, number)
         } do
      {:ok, result}
    else
      _ -> {:error, :already_issued}
    end
  end

  defp put_header(journal_entry_header, number) do
    %{
      journal_entry_header
      | accounting_document_number: number.current_document_number
    }
  end

  defp put_items(journal_entry_item, number) do
    Enum.map(journal_entry_item, fn item ->
      %{
        item
        | general_ledger_transaction:
            put_general_ledger_transaction(item.general_ledger_transaction, number)
      }
    end)
  end

  defp put_general_ledger_transaction(item_general_ledger_transaction, number) do
    %{
      item_general_ledger_transaction
      | accounting_document_number: number.current_document_number
    }
  end
end
