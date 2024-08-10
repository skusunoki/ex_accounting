defmodule ExAccounting.DataItemDictionaryTest do
  use ExUnit.Case

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
    AccountingDocumentHeader
  }

  alias ExAccounting.SystemDictionary.{
    UserName
  }

  doctest ExAccounting
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
  # doctest AccountingDocumentHeader
end
