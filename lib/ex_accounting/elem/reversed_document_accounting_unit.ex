defmodule ExAccounting.Elem.ReversedDocumentAccountingUnit do
  @moduledoc """
  _Reversed Document Accounting Unit_ is the Accounting Unit of the document to be reversed.
  """
  use Ecto.Type
  alias ExAccounting.Elem.AccountingUnit

  @typedoc "_Reversed Document Accounting Unit_"
  @type t :: %__MODULE__{
          reversed_document_accounting_unit: %AccountingUnit{accounting_unit: charlist}
        }
  defstruct reversed_document_accounting_unit: nil

  @doc """
  Defines the type of the _Reversed Document Accounting Unit_ in database as string.
  """
  @spec type() :: :string
  def type, do: :string

  @doc """
  Casts the given charlist to the _Reversed Document Accounting Unit_.

  ## Examples

      iex> cast(~C[1000])
      {:ok, %ReversedDocumentAccountingUnit{reversed_document_accounting_unit: %AccountingUnit{accounting_unit: ~C[1000]}}}
  """
  @spec cast(t | AccountingUnit.t() | charlist) :: {:ok, t()} | :error
  def cast(%__MODULE__{} = reversed_document_accounting_unit) do
    with %AccountingUnit{accounting_unit: code} <-
           reversed_document_accounting_unit.reversed_document_accounting_unit,
         {:ok, _} <- ExAccounting.Utility.validate(code) do
      {:ok, reversed_document_accounting_unit}
    else
      _ -> :error
    end
  end

  def cast(%AccountingUnit{} = accounting_unit) do
    with {:ok, _} <- ExAccounting.Utility.validate(accounting_unit.accounting_unit) do
      {:ok, %__MODULE__{reversed_document_accounting_unit: accounting_unit}}
    else
      _ -> :error
    end
  end

  def cast(accounting_unit) when is_list(accounting_unit) or is_binary(accounting_unit) do
    with {:ok, _} <- ExAccounting.Utility.validate(ExAccounting.Utility.to_c(accounting_unit)) do
      {:ok,
       %__MODULE__{reversed_document_accounting_unit: AccountingUnit.create(accounting_unit)}}
    else
      _ -> :error
    end
  end

  @doc """
  Dumps the _Reversed Document Accounting Unit_ to the string.

  ## Examples

      iex> dump(%ReversedDocumentAccountingUnit{reversed_document_accounting_unit: %AccountingUnit{accounting_unit: ~C[1000]}})
      {:ok, "1000"}
  """
  @spec dump(t) :: {:ok, String.t()} | :error
  def dump(%__MODULE__{
        reversed_document_accounting_unit: %AccountingUnit{accounting_unit: accounting_unit}
      }),
      do: {:ok, to_string(accounting_unit)}

  def dump(_), do: :error

  @doc """
  Loads the _Reversed Document Accounting Unit_ from the given database form data.

  ## Examples

      iex> load("1000")
      {:ok, %ReversedDocumentAccountingUnit{reversed_document_accounting_unit: %AccountingUnit{accounting_unit: ~C[1000]}}}
  """
  @spec load(String.t()) :: {:ok, t()} | :error
  def load(reversed_document_accounting_unit) do
    case ExAccounting.Utility.validate(
           ExAccounting.Utility.to_c(reversed_document_accounting_unit)
         ) do
      {:ok, validated} ->
        {:ok, %__MODULE__{reversed_document_accounting_unit: AccountingUnit.create(validated)}}

      {:error, _keyword} ->
        :error
    end
  end

  @doc """
  Converts the _Reversed Document Accounting Unit_ to _Accounting Unit_.

  ## Examples

      iex> to_accounting_unit(%ReversedDocumentAccountingUnit{reversed_document_accounting_unit: %AccountingUnit{accounting_unit: ~C[1000]}})
      {:ok, %AccountingUnit{accounting_unit: ~C[1000]}}
  """
  @spec to_accounting_unit(t) :: {:ok, AccountingUnit.t()} | :error
  def to_accounting_unit(%__MODULE__{reversed_document_accounting_unit: accounting_unit}) do
    {:ok, accounting_unit}
  end

  def to_accounting_unit(_), do: :error
end
