defmodule ExAccounting.State.CurrentAccountingDocumentNumberTest do
  use ExUnit.Case
  alias ExAccounting.State.CurrentAccountingDocumentNumber
  alias ExAccounting.Configuration.AccountingArea.AccountingDocumentNumberRange
  alias ExAccounting.Elem.AccountingDocumentNumberRangeCode
  alias ExAccounting.Elem.AccountingDocumentNumber
  doctest CurrentAccountingDocumentNumber, import: true

  test "Read current document number for number range 01 is 1_000_000_001" do
    with {:ok, code} <-
           AccountingDocumentNumberRangeCode
           |> Ecto.Type.cast("01"),
         result = code |> CurrentAccountingDocumentNumber.read() do
      assert result.number_range_code.accounting_document_number_range_code == ~c"01"
      assert result.current_document_number >= 1_000_000_000
    end
  end

  test "Read current document number for number range 02 is 2_000_000_000" do
    result =
      "02"
      |> AccountingDocumentNumberRangeCode.create()
      |> CurrentAccountingDocumentNumber.read()

    assert result.number_range_code.accounting_document_number_range_code == ~c"02"
    assert result.current_document_number.accounting_document_number >= 2_000_000_000
  end

  test "Read current document number for undefined number range DM is nil" do
    result =
      CurrentAccountingDocumentNumber.read(AccountingDocumentNumberRangeCode.create("DM"))

    assert result == nil
  end

  test "Issue new document number for number range 01 should be 1_000_000_002" do
    result =
      CurrentAccountingDocumentNumber.issue(
        AccountingDocumentNumberRangeCode.create("01"),
        fn _ ->
          %CurrentAccountingDocumentNumber{
            number_range_code: AccountingDocumentNumberRangeCode.create("01"),
            current_document_number: %AccountingDocumentNumber{
              accounting_document_number: 1_000_000_001
            }
          }
        end,
        fn _ ->
          [
            %AccountingDocumentNumberRange{
              number_range_code: AccountingDocumentNumberRangeCode.create("01"),
              accounting_document_number_from: %AccountingDocumentNumber{
                accounting_document_number: 1_000_000_000
              },
              accounting_document_number_to: %AccountingDocumentNumber{
                accounting_document_number: 1_999_999_999
              }
            }
          ]
        end
      )

    assert result.number_range_code == AccountingDocumentNumberRangeCode.create("01")
    assert result.current_document_number.accounting_document_number == 1_000_000_002
  end

  test "Issue new document number for number range 02 should be 2_000_000_001" do
    result =
      CurrentAccountingDocumentNumber.issue(
        AccountingDocumentNumberRangeCode.create("02"),
        fn _ ->
          %CurrentAccountingDocumentNumber{
            number_range_code: AccountingDocumentNumberRangeCode.create("02"),
            current_document_number: %AccountingDocumentNumber{
              accounting_document_number: 2_000_000_000
            }
          }
        end,
        fn _ ->
          %AccountingDocumentNumberRange{
            number_range_code: AccountingDocumentNumberRangeCode.create("02"),
            accounting_document_number_from: %AccountingDocumentNumber{
              accounting_document_number: 2_000_000_000
            },
            accounting_document_number_to: %AccountingDocumentNumber{
              accounting_document_number: 2_999_999_999
            }
          }
        end
      )

    assert result.number_range_code == AccountingDocumentNumberRangeCode.create("02")
    assert result.current_document_number.accounting_document_number == 2_000_000_001
  end

  test "Issue new document number for the undefined document number range 10 should be first number" do
    result =
      CurrentAccountingDocumentNumber.issue(
        AccountingDocumentNumberRangeCode.create(~c"10"),
        fn _ -> nil end,
        fn _ ->
          [
            %AccountingDocumentNumberRange{
              number_range_code: AccountingDocumentNumberRangeCode.create(~c"10"),
              accounting_document_number_from: 1_000_000_000,
              accounting_document_number_to: 1_999_999_999
            }
          ]
        end
      )

    assert result.number_range_code == AccountingDocumentNumberRangeCode.create(~c"10")

    assert result.current_document_number ==
             ExAccounting.Elem.AccountingDocumentNumber.create(1_000_000_000)
  end
end
