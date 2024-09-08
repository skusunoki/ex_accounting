defmodule ExAccounting.Elem.ClearingDocumentAccountingDocument do
  @moduledoc """
  _Clearing Document Accounting Document_ is the _Accounting Document Number_ that is reversed by the accounting document.
  """
  use Ecto.Type
  alias ExAccounting.Elem.AccountingDocumentNumber

  @typedoc "_Clearing Document Accounting Document_"
  @type t :: %__MODULE__{clearing_document_accunting_document: AccountingDocumentNumber.t()}

  @typedoc "_Accounting Document_"
  @type accounting_document :: AccountingDocumentNumber.t()

  defstruct clearing_document_accunting_document: nil

  @doc """
  Define database field type of _Clearing Document Accounting Document_
  """
  @spec type() :: :integer
  def type, do: :integer

  @doc """
  Casts the given _Accounting Document Number_ to the _Clearing Document Accounting Document_.

  ## Examples

      iex> cast(%AccountingDocumentNumber{accounting_document_number: 1010})
      {:ok, %ClearingDocumentAccountingDocument{clearing_document_accunting_document: %AccountingDocumentNumber{accounting_document_number: 1010}}}
  """
  @spec cast(t | accounting_document) :: {:ok, t()} | :error
  def cast(%__MODULE__{} = clearing_document_accunting_document) do
    with %__MODULE__{clearing_document_accunting_document: reversed} <-
           clearing_document_accunting_document,
         %AccountingDocumentNumber{accounting_document_number: _document_number} <- reversed do
      {:ok, clearing_document_accunting_document}
    else
      _ -> :error
    end
  end

  def cast(%AccountingDocumentNumber{} = accounting_document_number) do
    with %AccountingDocumentNumber{accounting_document_number: _document_number} <-
           accounting_document_number do
      {:ok, %__MODULE__{clearing_document_accunting_document: accounting_document_number}}
    else
      _ -> :error
    end
  end

  def cast(_), do: :error

  @doc """
  Dumps the _Clearing Document Accounting Document_ into the database form.

  ## Examples

      iex> dump(%ClearingDocumentAccountingDocument{clearing_document_accunting_document: %AccountingDocumentNumber{accounting_document_number: 1010}})
      {:ok, 1010}
  """
  @spec dump(t) :: {:ok, integer} | :error
  def dump(%__MODULE__{
        clearing_document_accunting_document: %AccountingDocumentNumber{
          accounting_document_number: document_number
        }
      }) do
    {:ok, document_number}
  end

  def dump(_), do: :error

  @doc """
  Loads the _Clearing Document Accounting Document_ from the database form.

  ## Examples

      iex> load(1010)
      {:ok, %ClearingDocumentAccountingDocument{clearing_document_accunting_document: %AccountingDocumentNumber{accounting_document_number: 1010}}}
  """
  @spec load(integer) :: {:ok, t()} | :error
  def load(document_number) do
    {:ok,
     %__MODULE__{
       clearing_document_accunting_document: %AccountingDocumentNumber{
         accounting_document_number: document_number
       }
     }}
  end

  @doc """
  Convert _Clearing Document Accounting Document_ to _Accounting Document Number_.

  ## Examples

      iex> to_accounting_document_number(%ClearingDocumentAccountingDocument{clearing_document_accunting_document: %AccountingDocumentNumber{accounting_document_number: 1010}})
      {:ok, %AccountingDocumentNumber{accounting_document_number: 1010}}
  """
  @spec to_accounting_document_number(t) :: {:ok, accounting_document()} | :error
  def to_accounting_document_number(%__MODULE__{
        clearing_document_accunting_document: accounting_document_number
      }) do
    {:ok, accounting_document_number}
  end
end
