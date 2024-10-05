defmodule ExAccounting.Elem.VatBaseAmountOfAccountingAreaCurrency do
  @moduledoc """
  _VAT Base Amount of Accounting Area Currency_ is the amount in the transaction currency.
  """

  use ExAccounting.Type

  amount(:vat_base_amount_of_accounting_area_currency,
    description: "VAT Base Amount of Accounting Area Currency"
  )
end
