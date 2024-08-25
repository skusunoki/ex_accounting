defmodule ExAccounting.ElemTest do
  use ExUnit.Case

  alias ExAccounting.Elem.AccountingDocumentNumberRangeCode

  alias ExAccounting.Elem.{
    FiscalYear,
    AccountingArea,
    AccountingDocumentNumber,
    AccountingUnit,
    DebitCredit,
    AccountingDocumentItemNumber,
    DocumentType,
    PostingDate,
    AccountingPeriod,
    DocumentDate,
    EntryDate,
    EnteredAt,
    EnteredBy,
    PostedBy,
    AccountingDocumentNumberRangeCode,
    ReverseDocumentIndicator,
    ReversedDocumentAccountingUnit
  }

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
  doctest EnteredBy
  doctest PostedBy
  doctest AccountingDocumentNumberRangeCode
  doctest ReverseDocumentIndicator
  doctest ReversedDocumentAccountingUnit
end
