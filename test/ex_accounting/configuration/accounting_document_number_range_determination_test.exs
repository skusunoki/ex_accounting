defmodule ExAccounting.Configuration.AccountingDocumentNumberRangeDeterminationTest do
  use ExUnit.Case

  test "from zero configuration" do
    assert ExAccounting.Configuration.AccountingDocumentNumberRangeDetermination.determine(
             %ExAccounting.Elem.AccountingUnit{accounting_unit: ~c"1000"},
             %ExAccounting.Elem.DocumentType{document_type: ~c"SA"},
             %ExAccounting.Elem.FiscalYear{fiscal_year: 2024},
             fn ->
               ExAccounting.Configuration.AccountingDocumentNumberRangeDeterminationTest.DummyRepo
             end
           ) == {:error, "Accounting Document Number Range Determination not found"}
  end

  test "hit configuration" do
    assert ExAccounting.Configuration.AccountingDocumentNumberRangeDetermination.determine(
             %ExAccounting.Elem.AccountingUnit{accounting_unit: ~c"1000"},
             %ExAccounting.Elem.DocumentType{document_type: ~c"SA"},
             %ExAccounting.Elem.FiscalYear{fiscal_year: 2024},
             fn ->
               ExAccounting.Configuration.AccountingDocumentNumberRangeDeterminationTest.FakeRepo
             end
           ) == %ExAccounting.Elem.AccountingDocumentNumberRangeCode{
             accounting_document_number_range_code: ~c"01"
           }
  end

  test "guess configuration" do
    assert ExAccounting.Configuration.AccountingDocumentNumberRangeDetermination.determine(
             %ExAccounting.Elem.AccountingUnit{accounting_unit: ~c"1000"},
             %ExAccounting.Elem.DocumentType{document_type: ~c"SA"},
             %ExAccounting.Elem.FiscalYear{fiscal_year: 2024},
             fn ->
               ExAccounting.Configuration.AccountingDocumentNumberRangeDeterminationTest.MockRepo
             end
           ) == %ExAccounting.Elem.AccountingDocumentNumberRangeCode{
             accounting_document_number_range_code: ~c"01"
           }
  end

  defmodule DummyRepo do
    def all(_) do
      []
    end
  end

  defmodule FakeRepo do
    def all(_) do
      [
        %ExAccounting.Configuration.AccountingDocumentNumberRangeDetermination{
          accounting_unit: %ExAccounting.Elem.AccountingUnit{accounting_unit: ~c"1000"},
          document_type: %ExAccounting.Elem.DocumentType{document_type: ~c"SA"},
          to_fiscal_year: %ExAccounting.Elem.FiscalYear{fiscal_year: 2024},
          number_range_code: %ExAccounting.Elem.AccountingDocumentNumberRangeCode{
            accounting_document_number_range_code: ~c"01"
          }
        }
      ]
    end
  end

  defmodule MockRepo do
    def all(_) do
      [
        %ExAccounting.Configuration.AccountingDocumentNumberRangeDetermination{
          accounting_unit: %ExAccounting.Elem.AccountingUnit{accounting_unit: ~c"1000"},
          document_type: %ExAccounting.Elem.DocumentType{document_type: ~c"SA"},
          to_fiscal_year: %ExAccounting.Elem.FiscalYear{fiscal_year: 2021},
          number_range_code: %ExAccounting.Elem.AccountingDocumentNumberRangeCode{
            accounting_document_number_range_code: ~c"XX"
          }
        },
        %ExAccounting.Configuration.AccountingDocumentNumberRangeDetermination{
          accounting_unit: %ExAccounting.Elem.AccountingUnit{accounting_unit: ~c"1000"},
          document_type: %ExAccounting.Elem.DocumentType{document_type: ~c"SA"},
          to_fiscal_year: %ExAccounting.Elem.FiscalYear{fiscal_year: 9999},
          number_range_code: %ExAccounting.Elem.AccountingDocumentNumberRangeCode{
            accounting_document_number_range_code: ~c"01"
          }
        }
      ]
    end
  end
end
