defmodule ExAccounting.Elem.AmountInAccountingUnitCurrency do
  @moduledoc """
  _Amount in Accounting Unit Currency_ is the amount in the accounting unit currency.
  """

  use ExAccounting.Type
  amount(:amount_in_accounting_unit_currency, description: "Amount in Accounting Unit Currency")
end
