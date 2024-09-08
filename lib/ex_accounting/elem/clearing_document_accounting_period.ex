defmodule ExAccounting.Elem.ClearingDocumentAccountingPeriod do
  @moduledoc """
  _Clearing Document Accounting Period_ is the _Accounting Period_ that is reversed by the accounting period.
  """

  use Ecto.Type
  alias ExAccounting.Elem.AccountingPeriod

  @typedoc "_Clearing Document Accounting Period_"
  @type t :: %__MODULE__{clearing_document_accounting_period: AccountingPeriod.t()}
  defstruct clearing_document_accounting_period: nil

  @typedoc "_Accounting Period_"
  @type accounting_period :: AccountingPeriod.t()

  @doc """
  Define database field type of _Clearing Document Accounting Period_.
  """
  @spec type() :: :integer
  def type, do: :integer

  @doc """
  Casts the given _Accounting Period_ to the _Clearing Document Accounting Period_.

  ## Examples

      iex> cast(%AccountingPeriod{accounting_period: 12})
      {:ok, %ClearingDocumentAccountingPeriod{clearing_document_accounting_period: %AccountingPeriod{accounting_period: 12}}}
  """
  @spec cast(t | accounting_period) :: {:ok, t()} | :error
  def cast(%__MODULE__{} = clearing_document_accounting_period) do
    with %__MODULE__{clearing_document_accounting_period: reversed} <-
           clearing_document_accounting_period,
         %AccountingPeriod{accounting_period: _document_period} <- reversed do
      {:ok, clearing_document_accounting_period}
    else
      _ -> :error
    end
  end

  def cast(%AccountingPeriod{} = accounting_period) do
    with %AccountingPeriod{accounting_period: _document_period} <-
           accounting_period do
      {:ok, %__MODULE__{clearing_document_accounting_period: accounting_period}}
    else
      _ -> :error
    end
  end

  @doc """
  Dumps the _Clearing Document Accounting Period_ into the database form.

  ## Examples

      iex> dump(%ClearingDocumentAccountingPeriod{clearing_document_accounting_period: %AccountingPeriod{accounting_period: 12}})
      {:ok, 12}
  """
  @spec dump(t) :: {:ok, integer} | :error
  def dump(%__MODULE__{clearing_document_accounting_period: clearing_document_accounting_period}) do
    {:ok, clearing_document_accounting_period.accounting_period}
  end

  def dump(_), do: :error

  @doc """
  Loads the _Clearing Document Accounting Period_ from the database form data.

  ## Examples

      iex> load(12)
      {:ok, %ClearingDocumentAccountingPeriod{clearing_document_accounting_period: %AccountingPeriod{accounting_period: 12}}}
  """
  @spec load(integer) :: {:ok, t()} | :error
  def load(clearing_document_accounting_period)
      when is_integer(clearing_document_accounting_period) do
    with {:ok, accounting_period} <- AccountingPeriod.load(clearing_document_accounting_period) do
      {:ok, %__MODULE__{clearing_document_accounting_period: accounting_period}}
    else
      _ -> :error
    end
  end
end
