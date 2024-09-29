defmodule ExAccounting.Elem.ProfitCenter do
  @moduledoc """
  _Profit Center_ is managirial accounting entity for evaluating its business performance.
  It is identified from the other profit centers by unique alphanumeric code less than or equals to 10 digits.
  """

  use ExAccounting.Type
  entity(:profit_center, type: :string, length: 10, description: "Profit Center")
end
