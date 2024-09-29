defmodule ExAccounting.Elem.OffsettingWbsElement do
  @moduledoc """
  _Offsetting WBS Element_ is the WBS element that is used to offset the WBS element of the original document.
  """
  use ExAccounting.Type
  entity :wbs_element, type: :string, length: 256, description: "Offsetting WBS Element"
end
