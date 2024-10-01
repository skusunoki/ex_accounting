defmodule ExAccounting.Elem.Order do
  @moduledoc """
  _Order_ is the atomic unit of the specific intent of business activities with cost.
  """

  use ExAccounting.Type
  sequence(:order, max: 9_999_999_999, description: "Order")
end
