defmodule ExAccounting.Elem.VendorTransactionType do
  @moduledoc """
  _Vendor Transaction Type_ is a code that identifies the type of transaction.

  101 - Invoice Received
  102 - Credit Note Received
  201 - Payment Made
  202 - Payment Cancelled

  """
  use ExAccounting.Type
  code(:vendor_transaction_type, type: :string, length: 3)
end
