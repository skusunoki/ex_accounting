defmodule ExAccounting.Elem.WbsElementTransactionType do
  @moduledoc """
  _WBS Element Transaction Type_ classifies the effects of a transaction on a WBS element.
  """
  use ExAccounting.Type

  code(:wbs_element_transaction_type,
    type: :string,
    length: 3,
    description: "WBS Element Transaction Type"
  )
end
