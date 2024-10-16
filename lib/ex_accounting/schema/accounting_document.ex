defmodule ExAccounting.Schema.AccountingDocument do
  @moduledoc """
  _Accounting Document_ is a representation of changes to values of general ledger and subledger accounts resulting from a business transaction and relating to a entity and a set of books.
  """

  @typedoc "_Accounting Document_"
  @type t :: %__MODULE__{
          accounting_document_header: ExAccounting.Schema.AccountingDocumentHeader.t(),
          accounting_document_items: [ExAccounting.Schema.AccountingDocumentItem.t()]
        }
  defstruct accounting_document_header: nil, accounting_document_items: nil

  @spec create(
          ExAccounting.Schema.AccountingDocumentHeader.t(),
          [ExAccounting.Schema.AccountingDocumentItem.t()]
        ) ::
          t()
  def create(accounting_document_header, accounting_document_items) do
    %__MODULE__{
      accounting_document_header: accounting_document_header,
      accounting_document_items: accounting_document_items
    }
  end
end
