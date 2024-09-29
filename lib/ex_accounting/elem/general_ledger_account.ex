defmodule ExAccounting.Elem.GeneralLedgerAccount do
  @moduledoc """
  _General Ledger Account_ is breakdown of aggregation units used to disclose and evaluate the financial position and profit calculations of an accounting unit, and are classifications based on the nature of transactions used in the continuous recording of double-entry bookkeeping and general ledger accounting.
  """

  use ExAccounting.Type

  entity(:general_ledger_account,
    type: :string,
    length: 10,
    description: "General Ledger Account"
  )
end
