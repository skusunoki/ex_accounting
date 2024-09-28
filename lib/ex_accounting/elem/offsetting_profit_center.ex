defmodule ExAccounting.Elem.OffsettingProfitCenter do
  @moduledoc false

  use ExAccounting.Type
  entity(:profit_center, type: :string, length: 10)
end
