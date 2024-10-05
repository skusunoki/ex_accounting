defmodule ExAccounting.Elem.VatBaseAmountOfAccountingUnitCurrency do
  @moduledoc """
  _VAT Base Amount of Accounting Unit Currency is the amount in the transaction currency.
  """

  use ExAccounting.Type

  amount(:vat_base_amount_of_accounting_unit_currency,
    description: "VAT Base Amount of Accounting Unit Currency"
  )
end
