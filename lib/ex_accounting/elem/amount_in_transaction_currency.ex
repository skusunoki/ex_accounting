defmodule ExAccounting.Elem.AmountInTransactionCurrency do
  @moduledoc """
  _Amount in Transaction Currency_ is the amount in the transaction currency.
  """

  use ExAccounting.Type
  amount(:amount_in_transaction_currency, description: "Amount in Transaction Currency")
end
