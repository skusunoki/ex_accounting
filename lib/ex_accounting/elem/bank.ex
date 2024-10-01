defmodule ExAccounting.Elem.Bank do
  @moduledoc """
  _Bank_ is the entity holds the bank account.
  """
  use ExAccounting.Type
  entity(:bank, length: 10, description: "Bank")
end
