defmodule ExAccounting.Elem.SalesOrderItem do
  @moduledoc """
  SalesOrderItem is identifier of accounting document item
  """
  use ExAccounting.Type
  sequence(:sales_order_item, max: 999_999, description: "Sales Order Item Number")
end
