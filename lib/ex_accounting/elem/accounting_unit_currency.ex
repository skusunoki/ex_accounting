defmodule ExAccounting.Elem.AccountingUnitCurrency do
  @moduledoc """
  _Accounting Unit Currency_ is the currency of accounting unit.
  """

  use ExAccounting.Type
  currency(:currency, description: "Accounting Unit Currency")
end
