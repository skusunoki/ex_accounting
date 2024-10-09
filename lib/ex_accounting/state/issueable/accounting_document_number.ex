defimpl ExAccounting.State.Issueable, for: ExAccounting.EmbeddedSchema.JournalEntry do
  @impl true
  def number(journal_entry) do
    with %ExAccounting.EmbeddedSchema.JournalEntry{
           header: %ExAccounting.EmbeddedSchema.JournalEntryHeader{
             accounting_document_number: accounting_document_number,
             document_type: document_type
           }
         }
         when is_nil(accounting_document_number) and not is_nil(document_type) <- journal_entry,
         number =
           ExAccounting.Configuration.AccountingDocumentNumberRangeDetermination.determine(
             document_type
           )
           |> ExAccounting.State.CurrentAccountingDocumentNumber.issue(),
         header = %{
           journal_entry.header
           | accounting_document_number: number.current_document_number
         },
         journal_entry = %{journal_entry | header: header} do
      {:ok, journal_entry}
    end
  end
end
