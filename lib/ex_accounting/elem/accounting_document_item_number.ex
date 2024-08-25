defmodule ExAccounting.Elem.AccountingDocumentItemNumber do
  @moduledoc """
  AccountingDocumentItemNumber is identifier of accounting document item
  """
  use Ecto.Type

  @typedoc "_Accounting Document Item Number_"
  @type t :: %__MODULE__{accounting_document_item_number: pos_integer}
  defstruct accounting_document_item_number: nil

  @doc """
  Defines the type of the _Accounting Document Item Number_ in database as integer.
  """
  @spec type() :: :integer
  def type, do: :integer

  @doc """
    Generates the valid _Accounting Document Number_ from the given positive integer.

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

  @doc """
  Casts the given postive integer to the _Accounting Document Item Number_.

  ## Exampples

      iex> AccountingDocumentItemNumber.cast(101)
      {:ok, %AccountingDocumentItemNumber{accounting_document_item_number: 101}}

      iex> AccountingDocumentItemNumber.cast(0)
      {:error, 0}

      iex> AccountingDocumentItemNumber.cast(1_000_000)
      {:error, 1_000_000}
  """
  @spec cast(pos_integer) :: {:ok, t()} | {:error, pos_integer}
  @spec cast(t) :: {:ok, t} | :error
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

  @doc """
  Dumps the _Accounting Document Item Number_ to the positive integer.

  ## Examples

      iex> AccountingDocumentItemNumber.dump(%AccountingDocumentItemNumber{accounting_document_item_number: 101})
      {:ok, 101}
  """
  @spec dump(t) :: {:ok, pos_integer} | :error
  def dump(
        %__MODULE__{accounting_document_item_number: number} = _accounting_document_item_number
      ) do
    {:ok, number}
  end

  def dump(_) do
    :error
  end

  @doc """
  Loads the _Accounting Document Item Number_ from the given database form data.
  """
  @spec load(integer) :: {:ok, t} | :error
  def load(data) do
    int_data = %{accounting_document_item_number: data}
    {:ok, struct!(__MODULE__, int_data)}
  end
end
