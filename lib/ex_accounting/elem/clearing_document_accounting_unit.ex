defmodule ExAccounting.Elem.ClearingDocumentAccountingUnit do
  @moduledoc """
  _Clearing Document Accounting Unit_ is the Accounting Unit of the document to be reversed.
  """
  alias ExAccounting.Elem.AccountingUnit
  use ExAccounting.Type
  code(:accounting_unit, type: :string, length: 4)

  @doc """
  Converts the _Clearing Document Accounting Unit_ to _Accounting Unit_.

  ## Examples

      iex> to_accounting_unit(%ClearingDocumentAccountingUnit{accounting_unit: ~C[1000]})
      {:ok, %AccountingUnit{accounting_unit: ~C[1000]}}
  """
  @spec to_accounting_unit(t) :: {:ok, AccountingUnit.t()} | :error
  def to_accounting_unit(%__MODULE__{accounting_unit: accounting_unit}) do
    {:ok, %AccountingUnit{accounting_unit: accounting_unit}}
  end

  def to_accounting_unit(_), do: :error
end
