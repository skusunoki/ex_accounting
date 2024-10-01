defmodule ExAccounting.Elem.VatAmountOfAccountingUnitCurrency do
  @moduledoc """
  _VAT Amount of Accounting Unit Currency is the amount in the transaction currency.
  """

  use ExAccounting.Type
  amount(:vat_amount_of_accounting_unit_currency, description: "VAT Amount of Accounting Unit Currency")
end
