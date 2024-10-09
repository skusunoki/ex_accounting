defmodule JournalEntryHeaderTest do
  use ExUnit.Case
  alias ExAccounting.EmbeddedSchema.JournalEntryHeader

  test "Journal Entry Header must be casted from map" do
    params = %{
      accounting_unit: "1000",
      document_date: ~D[2024-10-01],
      posting_date: ~D[2024-10-01]
    }

    result =
      %JournalEntryHeader{}
      |> JournalEntryHeader.changeset(params)
      |> Ecto.Changeset.apply_changes()

    assert result == %JournalEntryHeader{
             accounting_unit: %ExAccounting.Elem.AccountingUnit{
               accounting_unit: ~c"1000"
             },
             document_date: %ExAccounting.Elem.DocumentDate{
               document_date: ~D[2024-10-01]
             },
             posting_date: %ExAccounting.Elem.PostingDate{
               posting_date: ~D[2024-10-01]
             },
             accounting_document_number: nil,
             accounting_unit_attr: %ExAccounting.EmbeddedSchema.AccountingUnit{
               accounting_unit: %ExAccounting.Elem.AccountingUnit{
                 accounting_unit: ~c"1000"
               },
               accounting_unit_currency: %ExAccounting.Elem.AccountingUnitCurrency{
                 currency: :USD
               },
               accounting_area: %ExAccounting.EmbeddedSchema.AccountingArea{
                 accounting_area: %ExAccounting.Elem.AccountingArea{accounting_area: ~c"0001"},
                 accounting_area_description: %ExAccounting.Elem.AccountingAreaDescription{
                   accounting_area_description: "Default"
                 },
                 accounting_area_currency: %ExAccounting.Elem.AccountingAreaCurrency{
                   currency: :USD
                 }
               }
             }
           }
  end
end
