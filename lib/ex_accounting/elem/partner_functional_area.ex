defmodule ExAccounting.Elem.PartnerFunctionalArea do
  @moduledoc """
  _Partner Functional Area_ is identifier of a partner functional area.
  """

  use ExAccounting.Type
  entity(:functional_area, type: :string, length: 10)
end
