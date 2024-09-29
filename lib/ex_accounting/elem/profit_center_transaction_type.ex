defmodule ExAccounting.Elem.ProfitCenterTransactionType do
  @moduledoc """
  _Profit Center Transaction Type_ classifies the effects of a transaction on a profit center.
  """
  use ExAccounting.Type

  code(:profit_center_transaction_type,
    type: :string,
    length: 3,
    description: "Profit Center Transaction Type"
  )
end
