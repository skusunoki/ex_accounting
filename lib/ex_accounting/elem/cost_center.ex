defmodule ExAccounting.Elem.CostCenter do
  @moduledoc """
  A cost center is an organizational unit or department (sales, services, IT, finance, marketing, engineering, and so on)
  that is used to allocate the cost of a business activity to an existing budget.
  """

  use ExAccounting.Type
  entity(:cost_center, type: :string, length: 10)
end
