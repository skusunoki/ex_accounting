defmodule ExAccounting.Elem.DateOfExchangeRateToAccountingAreaCurrency do
  @moduledoc """
  _Date of Exchange Rate to Accounting Area Currency_ is the date of accounting document posted.

  _Posting date_ must be consistent with accounting period within an accounting document.
  """
  use ExAccounting.Type
  date :date_of_exchange_rate_to_accounting_area_currency
end
