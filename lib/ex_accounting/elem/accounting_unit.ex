defmodule ExAccounting.Elem.AccountingUnit do
  @moduledoc """
  AccountingUnit is unit of organization to external reporting.
  """

  use ExAccounting.Type
  code(:accounting_unit, type: :string, length: 4)
end
