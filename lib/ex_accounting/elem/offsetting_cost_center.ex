defmodule ExAccounting.Elem.OffsettingCostCenter do
  @moduledoc """
  _Offsetting Cost Center_ is the cost center of the offsetting item of the document.
  """

  use ExAccounting.Type
  entity(:cost_center, type: :string, length: 10)
end
