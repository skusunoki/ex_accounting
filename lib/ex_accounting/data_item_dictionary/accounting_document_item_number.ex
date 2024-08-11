defmodule ExAccounting.DataItemDictionary.AccountingDocumentItemNumber do
  @moduledoc """
  AccountingDocumentItemNumber is identifier of accounting document item
  """

  @type t :: %__MODULE__{accounting_document_item_number: pos_integer}
  defstruct accounting_document_item_number: nil

  @doc """
    [create] is function for generating valid AccountingDocumentNumber.

  ## Examples

    iex> AccountingDocumentItemNumber.create(101)
    %AccountingDocumentItemNumber{accounting_document_item_number: 101}
  """
  @spec create(pos_integer) :: t()
  def create(accounting_document_item_number)
      when is_number(accounting_document_item_number) and accounting_document_item_number > 0 and
             accounting_document_item_number <= 999_999 do
    %__MODULE__{accounting_document_item_number: accounting_document_item_number}
  end
end
