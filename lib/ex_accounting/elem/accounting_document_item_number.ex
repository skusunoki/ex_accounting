defmodule ExAccounting.Elem.AccountingDocumentItemNumber do
  @moduledoc """
  _Accounting Document Item Number_ is an identifier of accounting document item in the accounting document.
  Accounting Document Item Number must be unique positive integer within the accounting document.

  ## Examples

      iex> ExAccounting.Elem.AccountingDocumentItemNumber.cast(1)
      {:ok, %ExAccounting.Elem.AccountingDocumentItemNumber{accounting_document_item_number: 1}}

      iex> ExAccounting.Elem.AccountingDocumentItemNumber.cast(0)
      {:error, 0}
  """
  use ExAccounting.Type

  sequence(:accounting_document_item_number,
    type: :integer,
    max: 999_999,
    description: "Accounting Document Item Number"
  )
end
