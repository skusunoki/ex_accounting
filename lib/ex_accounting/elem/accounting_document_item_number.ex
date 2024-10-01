defmodule ExAccounting.Elem.AccountingDocumentItemNumber do
  @moduledoc """
  AccountingDocumentItemNumber is identifier of accounting document item
  """
  use ExAccounting.Type

  sequence(:accounting_document_item_number,
    type: :integer,
    max: 999_999,
    description: "Accounting Document Item Number"
  )
end
