defmodule ExAccounting.Elem.AccountingArea do
  @moduledoc """
  _Accounting Area_ is an organization unit for aggregation (consolidation) of multiple entities.
  """
  use ExAccounting.Type
  code(:accounting_area, length: 4, description: "Accounting Area")
end
