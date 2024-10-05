defmodule ExAccounting.Elem.VatAmountOfAccountingAreaCurrency do
  @moduledoc """
  _VAT Amount of Accounting Area Currency_ is the amount in the transaction currency.
  """

  use ExAccounting.Type

  amount(:vat_amount_of_accounting_area_currency,
    description: "VAT Amount of Accounting Area Currency"
  )
end
