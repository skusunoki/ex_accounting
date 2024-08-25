defmodule ExAccountingTest do
  use ExUnit.Case
  alias ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber
  alias ExAccounting.Configuration.AccountingDocumentNumberRange

  test "Issue new document number for the number range 01" do
    before =
      CurrentAccountingDocumentNumber.read(
        ExAccounting.Elem.AccountingDocumentNumberRangeCode.create("01")
      )

    {:ok, result} =
      ExAccounting.issue_accounting_document_number(
        "01",
        &CurrentAccountingDocumentNumber.read(&1),
        &AccountingDocumentNumberRange.read(&1)
      )

    assert result.current_document_number == before.current_document_number + 1
    assert result.number_range_code == before.number_range_code
  end

  test "Issue new document number for the number range x1" do
    {:error, result} =
      ExAccounting.issue_accounting_document_number(
        "x1",
        &CurrentAccountingDocumentNumber.read(&1),
        &AccountingDocumentNumberRange.read(&1)
      )

    assert result == "x1"
  end
end
