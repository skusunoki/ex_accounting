defmodule ExAccounting.Elem.CustomerTransactionType do
  use ExAccounting.Type
  code(:customer_transaction_type, type: :string, length: 3)
end
