defmodule ExAccounting.DataItemDictionary.AccountingDocumentNumber do
  @moduledoc """
  AccountingDocumentNumber is identification key for accounting document.
  """

  @type t :: %__MODULE__{accounting_document_number: pos_integer}
  defstruct accounting_document_number: nil

  @doc """
    [create] is function for generating valid AccountingDocumentNumber

  ## Examples

    iex> AccountingDocumentNumber.create(1010)
    %AccountingDocumentNumber{accounting_document_number: 1010}
  """
  @spec create(pos_integer) :: t()
  def create(accounting_document_number)
      when is_integer(accounting_document_number) and accounting_document_number > 0 and
             accounting_document_number <= 999_999_999_999 do
    %__MODULE__{accounting_document_number: accounting_document_number}
  end
end
