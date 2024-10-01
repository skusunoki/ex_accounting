defmodule ExAccounting.Elem.DateOfExchangeRateToAccountingUnitCurrency do
  @moduledoc """
  _Date of Exchange Rate to Accounting Unit Currency_ is the date of accounting document posted.

  _Posting date_ must be consistent with accounting period within an accounting document.
  """
  use ExAccounting.Type

  date(:date_of_exchange_rate_to_accounting_unit_currency,
    description: "Date of Exchange Rate to Accounting Unit Currency"
  )
end
