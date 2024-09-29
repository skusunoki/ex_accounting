defmodule ExAccounting.Elem.SalesOrderItemTransactionType do
  @moduledoc """
  _Sales Order Item Transaction Type_ classifies the effects of tranactions on sales order items.
  """
  use ExAccounting.Type

  code(:sales_order_item_transaction_type,
    type: :string,
    length: 3,
    description: "Sales Order Item Transaction Type"
  )
end
