defmodule ExAccounting.Elem.SalesOrderTransactionType do
  use ExAccounting.Type

  code(:sales_order_transaction_type, type: :string, length: 3)
end
