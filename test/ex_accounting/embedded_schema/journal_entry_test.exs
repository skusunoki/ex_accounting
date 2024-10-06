defmodule ExAccounting.EmbeddedSchema.JournalEntryTest do
  use ExUnit.Case

  test "debit total and credit total should be equal" do
    parameter = %{
      header: %{
        accounting_unit: "1000",
        document_date: ~D[2024-10-01],
        posting_date: ~D[2024-10-01],
        accounting_document_number: 0_000_000_001,
        transaction_currency: "USD"
      },
      item: [
        %{
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
            accounting_document_number: 0_000_000_001,
            accounting_document_item_number: 1,
            transaction_value: %{currency: "USD", amount: 100},
            accounting_area_value: %{currency: "USD", amount: 100},
            accounting_unit_value: %{currency: "USD", amount: 100}
          }
        },
        %{
          item_number: 2,
          general_ledger_transaction: %{
            accounting_area: "0001",
            accounting_unit: "1000",
            profit_center: "10000001",
            fiscal_year: 2024,
            accounting_period: 10,
            posting_date: ~D[2024-10-01],
            general_ledger_account: "50000",
            general_ledger_account_transaction_type: "100",
            debit_credit: :credit,
            accounting_document_number: 0_000_000_001,
            accounting_document_item_number: 2,
            transaction_value: %{currency: "USD", amount: 100},
            accounting_area_value: %{currency: "USD", amount: 100},
            accounting_unit_value: %{currency: "USD", amount: 100}
          }
        }
      ]
    }

    result =
      %ExAccounting.EmbeddedSchema.JournalEntry{}
      |> ExAccounting.EmbeddedSchema.JournalEntry.changeset(parameter)

    assert result |> Ecto.Changeset.traverse_errors(fn {msg, opts} -> {msg, opts} end) == %{}
  end
end
