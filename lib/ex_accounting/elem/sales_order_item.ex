defmodule ExAccounting.Elem.SalesOrderItem do
  @moduledoc """
  SalesOrderItem is identifier of accounting document item
  """
  use ExAccounting.Type
  sequence(:sales_order_item, type: :integer, max: 999_999)
end
