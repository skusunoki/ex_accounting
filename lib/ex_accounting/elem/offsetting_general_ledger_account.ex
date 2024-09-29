defmodule ExAccounting.Elem.OffsettingGeneralLedgerAccount do
  @moduledoc """
  _Offsetting General Ledger Account_ is the general ledger account of the offsetting item of the document.
  """

  use ExAccounting.Type

  entity(:general_ledger_account,
    type: :string,
    length: 10,
    description: "Offsetting General Ledger Account"
  )
end
