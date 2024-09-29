defmodule ExAccounting.Elem.OffsettingOrder do
  @moduledoc false

  use ExAccounting.Type
  sequence(:order, type: :integer, max: 999_999_999_999, description: "Offsetting order")
end
