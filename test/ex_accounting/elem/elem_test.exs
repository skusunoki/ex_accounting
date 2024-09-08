defmodule ExAccounting.ElemTest do
  use ExUnit.Case

  alias ExAccounting.Elem.AmountInTransactionCurrency
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
    ReversedDocumentAccountingUnit,
    ReversedDocumentFiscalYear,
    ReversedDocumentAccountingDocument,
    ReversedDocumentAccountingDocumentItem,
    ReversedDocumentAccountingPeriod,
    ClearingDocumentIndicator,
    ClearingDocumentAccountingUnit,
    ClearingDocumentFiscalYear,
    ClearingDocumentAccountingDocument,
    ClearingDocumentAccountingDocumentItem,
    ClearingDocumentAccountingPeriod,
    AmountInTransactionCurrency,
    AmountInAccountingAreaCurrency,
    AmountInAccountingUnitCurrency,
    TransactionCurrency,
    AccountingAreaCurrency,
    AccountingUnitCurrency
  }

  doctest FiscalYear, import: true
  doctest AccountingArea, import: true
  doctest AccountingDocumentNumber, import: true
  doctest AccountingUnit, import: true
  doctest DebitCredit, import: true
  doctest AccountingDocumentItemNumber, import: true
  doctest DocumentType, import: true
  doctest PostingDate, import: true
  doctest AccountingPeriod, import: true
  doctest DocumentDate, import: true
  doctest EntryDate, import: true
  doctest EnteredAt, import: true
  doctest EnteredBy, import: true
  doctest PostedBy, import: true
  doctest AccountingDocumentNumberRangeCode, import: true
  doctest ReverseDocumentIndicator, import: true
  doctest ReversedDocumentAccountingUnit, import: true
  doctest ReversedDocumentFiscalYear, import: true
  doctest ReversedDocumentAccountingDocument, import: true
  doctest ReversedDocumentAccountingDocumentItem, import: true
  doctest ReversedDocumentAccountingPeriod, import: true
  doctest ClearingDocumentIndicator, import: true
  doctest ClearingDocumentAccountingUnit, import: true
  doctest ClearingDocumentFiscalYear, import: true
  doctest ClearingDocumentAccountingDocument, import: true
  doctest ClearingDocumentAccountingDocumentItem, import: true
  doctest ClearingDocumentAccountingPeriod, import: true
  doctest AmountInTransactionCurrency, import: true
  doctest AmountInAccountingAreaCurrency, import: true
  doctest AmountInAccountingUnitCurrency, import: true
  doctest TransactionCurrency, import: true
  doctest AccountingAreaCurrency, import: true
  doctest AccountingUnitCurrency, import: true
end
