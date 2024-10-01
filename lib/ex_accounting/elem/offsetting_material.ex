defmodule ExAccounting.Elem.OffsettingMaterial do
  @moduledoc """
  _Offsetting Material_ is the Material of offsetting item in the accounting document.
  """
  use ExAccounting.Type
  entity(:material, length: 10, description: "Offsetting Material")
end
