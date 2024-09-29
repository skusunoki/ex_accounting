defmodule ExAccounting.Elem.OrderTransactionType do
  @moduledoc """
  _Order Transaction Type_ classifies the effects of the transaction on the order.
  """

  use ExAccounting.Type
  code(:order_transaction_type, length: 3, description: "Order Transaction Type")
end
