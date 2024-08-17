defmodule ExAccounting.DataItemDictionaryTest do
  use ExUnit.Case

  alias ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode

  alias ExAccounting.DataItemDictionary.{
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
    AccountingDocumentNumberRangeCode
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
end
