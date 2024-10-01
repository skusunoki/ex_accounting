defmodule ExAccounting.Elem.Material do
  @moduledoc """
  _Matrial_ is the inventory object
  """

  use ExAccounting.Type
  entity(:material, length: 10, description: "Material")
end
