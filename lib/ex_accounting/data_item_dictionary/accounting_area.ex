defmodule ExAccounting.DataItemDictionary.AccountingArea do
  @moduledoc """
  AccountingArea is an organization unit for aggregation (consolidation) of multiple entities.
  """
  @type t :: %__MODULE__{accounting_area: charlist}
  defstruct accounting_area: nil

  @doc """
    [create] is function for generating valid AccountingArea.

  ## Examples

    iex> AccountingArea.create(~C[0001])
    %AccountingArea{ accounting_area: ~C[0001] }
  """
  @spec create(charlist) :: t()
  def create(accounting_area) when accounting_area != nil and length(accounting_area) == 4 do
    %__MODULE__{accounting_area: accounting_area}
  end
end
