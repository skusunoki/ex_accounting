defmodule ExAccounting.Elem.OffsettingVendor do
  @moduledoc """
  _Offsetting Vendor_ is the vendor of the offsetting item of the docment
  """

  use ExAccounting.Type
  entity(:vendor, type: :string, length: 10, description: "Offsetting Vendor")
end
