defmodule ExAccounting.Elem.WbsElement do
  use ExAccounting.Type
  entity(:wbs_element, type: :string, length: 256)
end
