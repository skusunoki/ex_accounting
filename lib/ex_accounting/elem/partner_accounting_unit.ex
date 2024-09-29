defmodule ExAccounting.Elem.PartnerAccountingUnit do
  @moduledoc """
  AccountingUnit is unit of organization to external reporting.
  """

  use ExAccounting.Type
  code(:accounting_unit, type: :string, length: 4, description: "Partner Accounting Unit")
end
