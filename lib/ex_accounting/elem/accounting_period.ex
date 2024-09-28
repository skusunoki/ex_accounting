defmodule ExAccounting.Elem.AccountingPeriod do
  @moduledoc """
  _Accounting Period_ is a period of time for which the financial statements are prepared.
  """

  use ExAccounting.Type
  period(:accounting_period, max: 12)
end
