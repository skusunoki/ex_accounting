defmodule ExAccounting.Elem.ReversedDocumentAccountingDocument do
  @moduledoc """
  _Reversed Document Accounting Document_ is the _Accounting Document Number_ that is reversed by the accounting document.
  """
  use ExAccounting.Type

  sequence(:accounting_document_number,
    max: 999_999_999_999,
    description: "Accounting Document Number of Reversed Document"
  )

  def to_accounting_document_number(
        %__MODULE__{accounting_document_number: number} = _accounting_document_number
      ) do
    with {:ok, accounting_document_number} <-
           ExAccounting.Elem.AccountingDocumentNumber.cast(number) do
      accounting_document_number
    else
      _ -> :error
    end
  end
end
