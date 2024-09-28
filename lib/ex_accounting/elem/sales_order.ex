defmodule ExAccounting.Elem.SalesOrder do
  @moduledoc """
  _Sales Order_ is sequential unique number identifying the sales order.
  """
  use ExAccounting.Type
  sequence(:sales_order, type: :integer, max: 999_999_999_999)
end
