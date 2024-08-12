defmodule ExAccounting.JournalEntry.AccountingDocumentHeader do
  @moduledoc """
  TODO
  """
  @type t :: %__MODULE__{
          document_type: ExAccounting.DataItemDictionary.DocumentType.t(),
          posting_date: ExAccounting.DataItemDictionary.PostingDate.t(),
          accounting_period: ExAccounting.DataItemDictionary.AccountingPeriod.t(),
          document_date: ExAccounting.DataItemDictionary.DocumentDate.t(),
          entry_date: ExAccounting.DataItemDictionary.EntryDate.t(),
          entered_at: ExAccounting.DataItemDictionary.EnteredAt.t(),
          entered_by: ExAccounting.DataItemDictionary.EnteredBy.t(),
          posted_by: ExAccounting.DataItemDictionary.PostedBy.t()
        }
  defstruct document_type: nil,
            posting_date: nil,
            accounting_period: nil,
            document_date: nil,
            entry_date: nil,
            entered_at: nil,
            entered_by: nil,
            posted_by: nil

  @doc """
  ## Examples
        iex> AccountingDocumentHeader.create(
        ...> DocumentType.create(~C"DR"),
        ...> PostingDate.create(~D"2024-08-03"),
        ...> AccountingPeriod.create(08),
        ...> DocumentDate.create(~D"2024-08-04"),
        ...> EntryDate.create(~D"2024-08-05"),
        ...> EnteredAt.create(~T"12:34:56.00"),
        ...> EnteredBy.create(UserName.create("JohnDoe")),
        ...> PostedBy.create(UserName.create("Alice")))
        %AccountingDocumentHeader{
          document_type: %DocumentType{document_type: ~C"DR"},
          posting_date: %PostingDate{posting_date: ~D"2024-08-03"},
          accounting_period: %AccountingPeriod{accounting_period: 08},
          document_date: %DocumentDate{document_date: ~D"2024-08-04"},
          entry_date: %EntryDate{entry_date: ~D"2024-08-05"},
          entered_at: %EnteredAt{entered_at: ~T"12:34:56.00"},
          entered_by: %EnteredBy{entered_by: %UserName{user_name: ~C"johndoe"}},
          posted_by: %PostedBy{posted_by: %UserName{user_name: ~C"alice"}}}

  """
  @spec create(
          ExAccounting.DataItemDictionary.DocumentType.t(),
          ExAccounting.DataItemDictionary.PostingDate.t(),
          ExAccounting.DataItemDictionary.AccountingPeriod.t(),
          ExAccounting.DataItemDictionary.DocumentDate.t(),
          ExAccounting.DataItemDictionary.EntryDate.t(),
          ExAccounting.DataItemDictionary.EnteredAt.t(),
          ExAccounting.DataItemDictionary.EnteredBy.t(),
          ExAccounting.DataItemDictionary.PostedBy.t()
        ) :: ExAccounting.JournalEntry.AccountingDocumentHeader.t()
  def create(
        document_type,
        posting_date,
        accounting_period,
        document_date,
        entry_date,
        entered_at,
        entered_by,
        posted_by
      ) do
    %__MODULE__{
      document_type: document_type,
      posting_date: posting_date,
      accounting_period: accounting_period,
      document_date: document_date,
      entry_date: entry_date,
      entered_at: entered_at,
      entered_by: entered_by,
      posted_by: posted_by
    }
  end
end
