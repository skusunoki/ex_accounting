defmodule ExAccounting.Elem.PartnerCostCenter do
  @moduledoc """
  _Partner Cost Center_ is identifier of a partner cost center.
  """

  use ExAccounting.Type
  entity(:cost_center, type: :string, length: 10)
end
