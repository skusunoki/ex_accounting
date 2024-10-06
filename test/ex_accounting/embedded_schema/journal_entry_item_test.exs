defmodule ExAccounting.EmbeddedSchema.JournalEntryItemTest do
  use ExUnit.Case
  alias ExAccounting.EmbeddedSchema.JournalEntryItem

  test "embedded schema" do
    params = %{
      item_number: 1,
      general_ledger_transaction: %{
        accounting_area: "0001",
        accounting_unit: "1000",
        profit_center: "10000001",
        fiscal_year: 2024,
        accounting_period: 10,
        posting_date: ~D[2024-10-01],
        general_ledger_account: "30000",
        general_ledger_account_transaction_type: "100",
        debit_credit: :debit,
        transaction_value: %{currency: "USD", amount: 100},
        accounting_area_value: %{currency: "USD", amount: 100},
        accounting_unit_value: %{currency: "USD", amount: 100}
      }
    }

    result =
      %JournalEntryItem{}
      |> JournalEntryItem.changeset(params)
      |> Ecto.Changeset.apply_changes()

    assert result == %JournalEntryItem{
             item_number: %ExAccounting.Elem.AccountingDocumentItemNumber{
               accounting_document_item_number: 1
             },
             general_ledger_transaction: %ExAccounting.EmbeddedSchema.GeneralLedgerTransaction{
               accounting_area: %ExAccounting.Elem.AccountingArea{
                 accounting_area: ~c"0001"
               },
               accounting_unit: %ExAccounting.Elem.AccountingUnit{
                 accounting_unit: ~c"1000"
               },
               profit_center: %ExAccounting.Elem.ProfitCenter{
                 profit_center: ~c"10000001"
               },
               fiscal_year: %ExAccounting.Elem.FiscalYear{
                 fiscal_year: 2024
               },
               accounting_period: %ExAccounting.Elem.AccountingPeriod{
                 accounting_period: 10
               },
               posting_date: %ExAccounting.Elem.PostingDate{
                 posting_date: ~D[2024-10-01]
               },
               general_ledger_account: %ExAccounting.Elem.GeneralLedgerAccount{
                 general_ledger_account: ~c"30000"
               },
               general_ledger_account_transaction_type:
                 %ExAccounting.Elem.GeneralLedgerAccountTransactionType{
                   general_ledger_account_transaction_type: ~c"100"
                 },
               debit_credit: %ExAccounting.Elem.DebitCredit{
                 debit_credit: :debit
               },
               transaction_value: %ExAccounting.EmbeddedSchema.Money{
                 currency: %ExAccounting.Elem.Currency{
                   currency: :USD
                 },
                 amount: Decimal.new("100"),
                 cent_factor: 100
               },
               accounting_area_value: %ExAccounting.EmbeddedSchema.Money{
                 currency: %ExAccounting.Elem.Currency{
                   currency: :USD
                 },
                 amount: Decimal.new("100"),
                 cent_factor: 100
               },
               accounting_unit_value: %ExAccounting.EmbeddedSchema.Money{
                 currency: %ExAccounting.Elem.Currency{
                   currency: :USD
                 },
                 amount: Decimal.new("100"),
                 cent_factor: 100
               }
             }
           }
  end
end
