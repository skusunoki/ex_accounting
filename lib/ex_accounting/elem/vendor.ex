defmodule ExAccounting.Elem.Vendor do
  @moduledoc """
  _Vendor_ is the individual or entity to whom the accounting unit pays money for goods, service or the other purpose.
  """

  use ExAccounting.Type
  entity(:vendor, type: :string, length: 10, description: "Vendor")
end
