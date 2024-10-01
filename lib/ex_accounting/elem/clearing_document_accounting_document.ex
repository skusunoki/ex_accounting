defmodule ExAccounting.Elem.ClearingDocumentAccountingDocument do
  @moduledoc """
  _Clearing Document Accounting Document_ is the _Accounting Document Number_ that is reversed by the accounting document.
  """
  use ExAccounting.Type

  sequence(:accounting_document_number,
    type: :integer,
    max: 999_999_999_999,
    description: "Accounting Document Number of Cleared Document"
  )
end
