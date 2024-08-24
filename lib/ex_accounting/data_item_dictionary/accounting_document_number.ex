defmodule ExAccounting.DataItemDictionary.AccountingDocumentNumber do
  @moduledoc """
  _Accounting Document Number_ is sequential unique number to identify the accounting document.
  """
  use Ecto.Type

  @typedoc "_Accounting Document Number_"
  @type t :: %__MODULE__{accounting_document_number: pos_integer}
  defstruct accounting_document_number: nil

  @doc """
  Defines the type of the _Accounting Document Number_ in database as integer.
  """
  @spec type() :: :integer
  def type, do: :integer

  @doc """
  Casts the given positive integer to the _Accounting Document Number_.

  ## Examples

        iex> AccountingDocumentNumber.cast(1010)
        {:ok, %AccountingDocumentNumber{accounting_document_number: 1010}}

        iex> AccountingDocumentNumber.cast(0)
        {:error, 0}

        iex> AccountingDocumentNumber.cast(1_000_000_000_000)
        {:error, 1_000_000_000_000}
  """
  @spec cast(t | pos_integer) :: {:ok, t()} | {:error, pos_integer}
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

  @doc """
  Dumps the _Accounting Document Number_ to the integer.

  ## Examples

      iex> AccountingDocumentNumber.dump(%AccountingDocumentNumber{accounting_document_number: 1010})
      {:ok, 1010}
  """
  @spec dump(t) :: {:ok, pos_integer} | :error
  def dump(%__MODULE__{} = accounting_document_number) do
    with %__MODULE__{accounting_document_number: number} <- accounting_document_number do
      {:ok, number}
    else
      _ -> :error
    end
  end

  @doc """
  Loads the _Accounting Document Number_ from the given database form.

  ## Examples

      iex> AccountingDocumentNumber.load(1010)
      {:ok, %AccountingDocumentNumber{accounting_document_number: 1010}}
  """
  @spec load(integer) :: {:ok, t} | :error
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
