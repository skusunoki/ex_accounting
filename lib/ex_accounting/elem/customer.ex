defmodule ExAccounting.Elem.Customer do
  @moduledoc """
  _Customer_ is a individual or entity that buys goods or services from the accounting unit.
  """

  use ExAccounting.Type
  entity(:customer, type: :string, length: 10, description: "Customer")
end
