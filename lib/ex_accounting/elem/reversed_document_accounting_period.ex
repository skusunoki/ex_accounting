defmodule ExAccounting.Elem.ReversedDocumentAccountingPeriod do
  @moduledoc """
  _Reversed Document Accounting Period_ is the _Accounting Period_ that is reversed by the accounting period.
  """

  use ExAccounting.Type
  period(:accouting_period, max: 12, description: "Accounting Period of Reversed Document")
end
