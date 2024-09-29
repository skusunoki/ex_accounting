defmodule ExAccounting.Elem.GeneralLedgerAccountTransactionType do
  use ExAccounting.Type

  code(:general_ledger_account_transaction_type,
    length: 3,
    description: "General Ledger Account Transaction Type"
  )
end
