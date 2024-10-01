defmodule ExAccounting.Elem.AccountingDocumentNumber do
  @moduledoc """
  _Accounting Document Number_ is sequential unique number to identify the accounting document.
  """
  use ExAccounting.Type

  sequence(:accounting_document_number,
    type: :integer,
    max: 999_999_999_999,
    description: "Accounting Document Number"
  )

  def to_reversed_accounting_document_number(
        %__MODULE__{accounting_document_number: number} = _accounting_document_number
      ) do
    with {:ok, accounting_document_number} <-
           ExAccounting.Elem.ReversedDocumentAccountingDocument.cast(number) do
      accounting_document_number
    else
      _ -> :error
    end
  end
end
