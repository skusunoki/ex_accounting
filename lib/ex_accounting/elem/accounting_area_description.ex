defmodule ExAccounting.Elem.AccountingAreaDescription do
  @moduledoc """
  _Description of the Accounting Area_ is a text field to describe the accounting area.
  """
  use ExAccounting.Type

  description(:accounting_area_description,
    length: 40,
    description: "Description of the Accounting Area"
  )
end
