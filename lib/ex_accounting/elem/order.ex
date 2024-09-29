defmodule ExAccounting.Elem.Order do
  @moduledoc """
  _Order_ is the atomic unit of the specific intent of business activities with cost.
  """

  use ExAccounting.Type
  entity(:order, type: :string, length: 10, description: "Order")
end
