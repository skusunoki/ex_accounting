defmodule ExAccountingTest do
  use ExUnit.Case
  alias ExAccounting.State.CurrentAccountingDocumentNumber
  alias ExAccounting.Configuration.AccountingArea

  test "Issue new document number for the number range 01" do
    before =
      CurrentAccountingDocumentNumber.read(
        ExAccounting.Elem.AccountingDocumentNumberRangeCode.create(~c"01")
      )

    {:ok, result} =
      ExAccounting.issue_accounting_document_number(
        ~c"01",
        &CurrentAccountingDocumentNumber.read(&1),
        &AccountingArea.read_accounting_document_number_range("0001", &1)
      )

    assert result.current_document_number.accounting_document_number ==
             before.current_document_number.accounting_document_number + 1

    assert result.number_range_code == before.number_range_code
  end

  test "Issue new document number for the number range x1" do
    {:error, result} =
      ExAccounting.issue_accounting_document_number(
        ~c"x1",
        &CurrentAccountingDocumentNumber.read(&1),
        &AccountingArea.read_accounting_document_number_range("0001", &1)
      )

    assert result == ~c"x1"
  end
end
