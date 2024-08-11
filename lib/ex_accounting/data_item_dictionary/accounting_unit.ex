
defmodule ExAccounting.DataItemDictionary.AccountingUnit do
  @moduledoc """
  AccountingUnit is unit of organization to external reporting.
  """

  @type t :: %__MODULE__{accounting_unit: charlist}
  defstruct accounting_unit: nil

  @doc """
    [create] is function for generating valid AccountingUnit

  ## Examples

    iex> AccountingUnit.create(~C[1000])
    %AccountingUnit{ accounting_unit: ~C[1000]}

  """

  @spec create(charlist) :: t()
  def create(accounting_unit) when length(accounting_unit) == 4 do
    %__MODULE__{accounting_unit: accounting_unit}
  end
end
