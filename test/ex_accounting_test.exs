defmodule ExAccountingTest do
  use ExUnit.Case
  alias ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber

  test "Issue new document number for the number range 01" do
    before = CurrentAccountingDocumentNumber.read("01")
    {:ok, result} = ExAccounting.issue_accounting_document_number("01")
    assert result.current_document_number == before.current_document_number + 1
    assert result.number_range_code == before.number_range_code
  end
end
