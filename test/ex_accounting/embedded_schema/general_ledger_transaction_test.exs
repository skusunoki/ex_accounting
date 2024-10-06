defmodule ExAccounting.EmbeddedSchema.GenralLedgerTransactionTest do
  use ExUnit.Case
  alias ExAccounting.EmbeddedSchema.GeneralLedgerTransaction
  doctest GeneralLedgerTransaction, import: true

  test "Create a new general ledger transaction" do
    with params = %{
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
         },
         result =
           %GeneralLedgerTransaction{}
           |> GeneralLedgerTransaction.changeset(params)
           |> Ecto.Changeset.cast_embed(:transaction_value,
             with: &ExAccounting.EmbeddedSchema.Money.changeset/2
           )
           |> Ecto.Changeset.cast_embed(:accounting_area_value,
             with: &ExAccounting.EmbeddedSchema.Money.changeset/2
           )
           |> Ecto.Changeset.cast_embed(:accounting_unit_value,
             with: &ExAccounting.EmbeddedSchema.Money.changeset/2
           )
           |> Ecto.Changeset.apply_changes() do
      assert result.accounting_area == %ExAccounting.Elem.AccountingArea{
               accounting_area: ~c"0001"
             }

      assert result.transaction_value.currency == %ExAccounting.Elem.Currency{
               currency: :USD
             }

      assert result.transaction_value.amount == Decimal.new("100")
      IO.inspect(result)
    end
  end
end
