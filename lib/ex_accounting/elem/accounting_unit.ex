defmodule ExAccounting.Elem.AccountingUnit do
  @moduledoc """
  AccountingUnit is unit of organization to external reporting.
  """

  use ExAccounting.Type
  code(:accounting_unit, length: 4, description: "Accounting Unit")
end
