defmodule ExAccounting.Elem.PaymentServiceTransactionType do
  use ExAccounting.Type
  code(:payment_service_transaction_type, type: :string, length: 3)
end
