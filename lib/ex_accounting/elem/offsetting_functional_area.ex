defmodule ExAccounting.Elem.OffsettingFunctionalArea do
  @moduledoc """
  _Offsetting Functional Area_ is the functional area of the offsetting item of the document.
  """

  use ExAccounting.Type
  entity(:functional_area, type: :string, length: 10)
end
