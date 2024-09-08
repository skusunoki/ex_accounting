defmodule ExAccounting.Elem.ClearingDocumentAccountingDocumentItem do
  @moduledoc """
  _Clearing Document Accounting Document Item_ is the _Accounting Document Item_ of the _Clearing Document Accounting Document_.
  """

  use Ecto.Type
  alias ExAccounting.Elem.AccountingDocumentItemNumber

  @typedoc """
  _Clearing Document Accounting Document Item_
  """
  @type t :: %__MODULE__{
          clearing_document_accounting_document_item: AccountingDocumentItemNumber.t()
        }

  @typedoc """
  _Accounting Document Item_
  """
  @type accounting_document_item :: AccountingDocumentItemNumber.t()

  defstruct clearing_document_accounting_document_item: nil

  @doc """
  Define database field type of _Clearing Document Accounting Document Item_.
  """
  @spec type() :: :integer
  def type, do: :integer

  @doc """
  Casts the given _Accounting Document Item_ to the _Clearing Document Accounting Document Item_.

  ## Examples

      iex> cast(%AccountingDocumentItemNumber{accounting_document_item_number: 1010})
      {:ok, %ClearingDocumentAccountingDocumentItem{clearing_document_accounting_document_item: %AccountingDocumentItemNumber{accounting_document_item_number: 1010}}}

      iex> cast(1010)
      {:ok, %ClearingDocumentAccountingDocumentItem{clearing_document_accounting_document_item: %AccountingDocumentItemNumber{accounting_document_item_number: 1010}}}

      iex> cast( %ClearingDocumentAccountingDocumentItem{ clearing_document_accounting_document_item: %AccountingDocumentItemNumber{ accounting_document_item_number: 1010 } })
      {:ok, %ClearingDocumentAccountingDocumentItem{ clearing_document_accounting_document_item: %AccountingDocumentItemNumber{ accounting_document_item_number: 1010 } }}
  """
  @spec cast(t | accounting_document_item) :: {:ok, t()} | :error
  def cast(%__MODULE__{} = clearing_document_accounting_document_item) do
    with %__MODULE__{clearing_document_accounting_document_item: reversed} <-
           clearing_document_accounting_document_item,
         {:ok, casted} <- AccountingDocumentItemNumber.cast(reversed) do
      {:ok, %__MODULE__{clearing_document_accounting_document_item: casted}}
    else
      _ -> :error
    end
  end

  def cast(%AccountingDocumentItemNumber{} = accounting_document_item) do
    with {:ok, casted} <- AccountingDocumentItemNumber.cast(accounting_document_item) do
      {:ok, %__MODULE__{clearing_document_accounting_document_item: casted}}
    else
      _ -> :error
    end
  end

  def cast(number) when is_integer(number) do
    with {:ok, casted} <- AccountingDocumentItemNumber.cast(number) do
      {:ok, %__MODULE__{clearing_document_accounting_document_item: casted}}
    else
      _ -> :error
    end
  end

  @doc """
  Dumps the _Clearing Document Accounting Document Item_ into the database form.

  ## Examples

      iex> dump(%ClearingDocumentAccountingDocumentItem{clearing_document_accounting_document_item: %AccountingDocumentItemNumber{accounting_document_item_number: 1010}})
      {:ok, 1010}
  """
  @spec dump(t) :: {:ok, integer} | :error
  def dump(%__MODULE__{
        clearing_document_accounting_document_item: accounting_document_item_number
      }) do
    with {:ok, dumped} <- AccountingDocumentItemNumber.dump(accounting_document_item_number) do
      {:ok, dumped}
    else
      _ -> :error
    end
  end

  @doc """
  Loads the _Clearing Document Accounting Document Item_ from the database form data.

  ## Examples

      iex> load(1010)
      {:ok, %ClearingDocumentAccountingDocumentItem{clearing_document_accounting_document_item: %AccountingDocumentItemNumber{accounting_document_item_number: 1010}}}
  """
  @spec load(integer) :: {:ok, t()} | :error
  def load(number) do
    with {:ok, loaded} <- AccountingDocumentItemNumber.load(number) do
      {:ok, %__MODULE__{clearing_document_accounting_document_item: loaded}}
    else
      _ -> :error
    end
  end
end
