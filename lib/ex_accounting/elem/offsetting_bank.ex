defmodule ExAccounting.Elem.OffsettingBank do
  @moduledoc """
  _Offsettning Bank_ is the bank entitiy of offsetting item in the accounting document.
  """

  use ExAccounting.Type
  entity(:bank, length: 10, description: "Offsetting Bank")
end
