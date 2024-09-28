defmodule ExAccounting.Elem.FunctionalArea do
  @moduledoc """
  _Functional Area_ is identifier of a functional area.
  """

  use ExAccounting.Type
  entity(:functional_area, type: :string, length: 10)
end
