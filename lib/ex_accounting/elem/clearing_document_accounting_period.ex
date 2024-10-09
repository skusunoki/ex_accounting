defmodule ExAccounting.Elem.ClearingDocumentAccountingPeriod do
  @moduledoc """
  _Clearing Document Accounting Period_ is the _Accounting Period_ that is reversed by the accounting period.
  """

  use ExAccounting.Type
  period(:accounting_period, max: 12, description: "Accounting Period of Clearing Document")
end
