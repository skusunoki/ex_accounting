defmodule ExAccounting.Elem.AccountingArea do
  @moduledoc """
  _Accounting Area_ is an organization unit for aggregation (consolidation) of multiple entities.
  The code of Accounting Area must be 4 digits.

  ## Examples

      iex> ExAccounting.Elem.AccountingArea.cast("0001")
      {:ok, %ExAccounting.Elem.AccountingArea{accounting_area: ~c"0001"}}

      iex> ExAccounting.Elem.AccountingArea.cast("000")
      {:error, "Accounting Area must be 4 characters. ~c\\"000\\" is 3 charactors."}
  """
  use ExAccounting.Type
  code(:accounting_area, length: 4, description: "Accounting Area")
end
