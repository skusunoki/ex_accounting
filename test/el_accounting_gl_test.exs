defmodule ElAccountingGlTest do
  use ExUnit.Case
  doctest ElAccountingGl
  doctest FiscalYear
  doctest AccountingArea
  doctest AccountingDocumentNumber
  doctest AccountingUnit
  doctest DebitCredit
  doctest AccountingDocumentItemNumber
  doctest DocumentType
  doctest PostingDate
  doctest AccountingPeriod
  doctest DocumentDate
  doctest EntryDate
  doctest EnteredAt
  doctest UserName
  doctest EnteredBy
  doctest PostedBy
  doctest AccountingDocumentHeader

  test "greets the world" do
    assert ElAccountingGl.hello() == :world
  end
end
