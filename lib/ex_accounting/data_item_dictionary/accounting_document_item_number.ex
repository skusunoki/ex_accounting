defmodule ExAccounting.DataItemDictionary.AccountingDocumentItemNumber do
  @moduledoc """
  AccountingDocumentItemNumber is identifier of accounting document item
  """
  use Ecto.Type
  def type, do: :integer

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

  def cast(%__MODULE__{accounting_document_item_number: number} = accounting_document_item_number) do
    with true <- is_number(number),
         true <- number > 0,
         true <- number <= 999_999 do
      {:ok, accounting_document_item_number}
    else
      false -> {:error, accounting_document_item_number}
    end
  end

  def cast(number) do
    with true <- is_number(number),
         true <- number > 0,
         true <- number <= 999_999 do
      {:ok, create(number)}
    else
      false -> {:error, number}
    end
  end

  def dump(
        %__MODULE__{accounting_document_item_number: number} = _accounting_document_item_number
      ) do
    {:ok, number}
  end

  def dump(_) do
    :error
  end

  def load(data) do
    int_data = %{accounting_document_item_number: data}
    {:ok, struct!(__MODULE__, int_data)}
  end
end
