defmodule ExAccounting.CurrentStatus.CurrentAccountingDocumentNumberTest do
  use ExUnit.Case
  alias ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber
  alias ExAccounting.Configuration.AccountingDocumentNumberRange
  alias ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode

  test "Incremented current number 100 should be 101" do
    assert CurrentAccountingDocumentNumber.increment(%{
             number_range_code: "01",
             current_document_number: 100
           }) == %{
             number_range_code: "01",
             current_document_number: 101
           }
  end

  test "Read current document number for number range 01 is 1_000_000_001" do
    result =
      CurrentAccountingDocumentNumber.read(AccountingDocumentNumberRangeCode.create("01"))

    assert result.number_range_code.accounting_document_number_range_code == "01"
    assert result.current_document_number >= 1_000_000_000
  end

  test "Read current document number for number range 02 is 2_000_000_000" do
    result =
      CurrentAccountingDocumentNumber.read(AccountingDocumentNumberRangeCode.create("02"))

    assert result.number_range_code.accounting_document_number_range_code == "02"
    assert result.current_document_number >= 2_000_000_000
  end

  test "Read current document number for undefined number range 10 is nil" do
    result =
      CurrentAccountingDocumentNumber.read(AccountingDocumentNumberRangeCode.create("10"))

    assert result == nil
  end

  test "Issue new document number for number range 01 should be 1_000_000_002" do
    {_, _, result} =
      CurrentAccountingDocumentNumber.issue(
        AccountingDocumentNumberRangeCode.create("01"),
        fn _ ->
          %CurrentAccountingDocumentNumber{
            number_range_code: AccountingDocumentNumberRangeCode.create("01"),
            current_document_number: 1_000_000_001
          }
        end,
        fn _ ->
          %AccountingDocumentNumberRange{
            number_range_code: AccountingDocumentNumberRangeCode.create("01"),
            accounting_document_number_from: 1_000_000_000,
            accounting_document_number_to: 1_999_999_999
          }
        end
      )

    assert result.number_range_code == AccountingDocumentNumberRangeCode.create("01")
    assert result.current_document_number == 1_000_000_002
  end

  test "Issue new document number for number range 02 should be 2_000_000_001" do
    {_, _, result} =
      CurrentAccountingDocumentNumber.issue(
        AccountingDocumentNumberRangeCode.create("02"),
        fn _ ->
          %CurrentAccountingDocumentNumber{
            number_range_code: AccountingDocumentNumberRangeCode.create("02"),
            current_document_number: 2_000_000_000
          }
        end,
        fn _ ->
          %AccountingDocumentNumberRange{
            number_range_code: AccountingDocumentNumberRangeCode.create("02"),
            accounting_document_number_from: 2_000_000_000,
            accounting_document_number_to: 2_999_999_999
          }
        end
      )

    assert result.number_range_code == AccountingDocumentNumberRangeCode.create("02")
    assert result.current_document_number == 2_000_000_001
  end

  test "Issue new document number for the undefined document number range 10 should be first number" do
    {_, _, result} =
      CurrentAccountingDocumentNumber.issue(
        AccountingDocumentNumberRangeCode.create("01"),
        fn _ -> nil end,
        fn _ ->
          %AccountingDocumentNumberRange{
            number_range_code: AccountingDocumentNumberRangeCode.create("01"),
            accounting_document_number_from: 1_000_000_000,
            accounting_document_number_to: 1_999_999_999
          }
        end
      )

    assert result.number_range_code == AccountingDocumentNumberRangeCode.create("01")
    assert result.current_document_number == 1_000_000_000
  end
end
