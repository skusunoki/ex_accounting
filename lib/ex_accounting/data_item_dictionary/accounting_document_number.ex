defmodule ExAccounting.DataItemDictionary.AccountingDocumentNumber do
  @moduledoc """
  _Accounting Document Number_ is sequential unique number to identify the accounting document.
  """
  use Ecto.Type

  @type t :: %__MODULE__{accounting_document_number: pos_integer}
  defstruct accounting_document_number: nil

  def type, do: :integer

  def cast(%__MODULE__{} = accounting_document_number) do
    with %__MODULE__{accounting_document_number: number} <- accounting_document_number,
         true <- is_number(number),
         true <- number > 0,
         true <- number <= 999_999_999_999 do
      {:ok, accounting_document_number}
    else
      _ -> {:error, accounting_document_number}
    end
  end

  def cast(accounting_document_number) when is_number(accounting_document_number) do
    with true <- accounting_document_number > 0,
         true <- accounting_document_number <= 999_999_999_999 do
      {:ok, %__MODULE__{accounting_document_number: accounting_document_number}}
    else
      _ -> {:error, accounting_document_number}
    end
  end

  def dump(%__MODULE__{} = accounting_document_number) do
    with %__MODULE__{accounting_document_number: number} <- accounting_document_number do
      {:ok, number}
    else
      _ -> :error
    end
  end

  def load(number) when is_number(number) do
    with true <- number > 0,
         true <- number <= 999_999_999_999 do
      {:ok, %__MODULE__{accounting_document_number: number}}
    else
      _ -> :error
    end
  end

  @doc """
    Generate valid _Accounting Document Number_

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
