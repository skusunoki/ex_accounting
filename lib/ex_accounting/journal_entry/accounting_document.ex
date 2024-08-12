defmodule ExAccounting.JournalEntry.AccountingDocument do
  @moduledoc """
  TODO
  """
  @type t :: %__MODULE__{
          accounting_document_header: ExAccounting.JournalEntry.AccountingDocumentHeader.t(),
          accounting_document_items: [ExAccounting.JournalEntry.AccountingDocumentItem.t()]
        }
  defstruct accounting_document_header: nil, accounting_document_items: nil

  @spec create(
          ExAccounting.JournalEntry.AccountingDocumentHeader.t(),
          [ExAccounting.JournalEntry.AccountingDocumentItem.t()]
        ) ::
          t()
  def create(accounting_document_header, accounting_document_items) do
    %__MODULE__{
      accounting_document_header: accounting_document_header,
      accounting_document_items: accounting_document_items
    }
  end
end
