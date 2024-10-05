defmodule ExAccounting.ElemTest do
  use ExUnit.Case

  alias ExAccounting.Elem.AmountInTransactionCurrency
  alias ExAccounting.Elem.AccountingDocumentNumberRangeCode

  alias ExAccounting.Elem.{
    AccountingAreaCurrency,
    AccountingArea,
    AccountingDocumentItemNumber,
    AccountingDocumentNumberRangeCode,
    AccountingDocumentNumber,
    AccountingPeriod,
    AccountingUnitCurrency,
    AccountingUnit,
    AmountInAccountingAreaCurrency,
    AmountInAccountingUnitCurrency,
    AmountInTransactionCurrency,
    Bank,
    ClearingDocumentAccountingDocumentItem,
    ClearingDocumentAccountingDocument,
    ClearingDocumentAccountingPeriod,
    ClearingDocumentAccountingUnit,
    ClearingDocumentFiscalYear,
    ClearingDocumentIndicator,
    CostCenterTransactionType,
    CostCenter,
    Currency,
    CustomerTransactionType,
    Customer,
    DateOfExchangeRateToAccountingAreaCurrency,
    DateOfExchangeRateToAccountingUnitCurrency,
    DebitCredit,
    DocumentDate,
    DocumentType,
    EnteredAt,
    EnteredBy,
    EntryDate,
    ExchangeRateToAccountingAreaCurrency,
    ExchangeRateToAccountingUnitCurrency,
    ExchangeRateTypeToAccountingAreaCurrency,
    ExchangeRateTypeToAccountingUnitCurrency,
    FiscalYear,
    FixedAssetTransactionType,
    FixedAsset,
    FunctionalAreaTransactionType,
    FunctionalArea,
    GeneralLedgerAccountTransactionType,
    GeneralLedgerAccount,
    Language,
    Zip,
    Material,
    OffsettingBank,
    OffsettingCostCenter,
    OffsettingCustomer,
    OffsettingFixedAsset,
    OffsettingFunctionalArea,
    OffsettingGeneralLedgerAccount,
    OffsettingMaterial,
    OffsettingOrder,
    OffsettingPaymentService,
    OffsettingProfitCenter,
    OffsettingVendor,
    OffsettingWbsElement,
    OrderTransactionType,
    Order,
    PartnerAccountingUnit,
    PartnerCostCenter,
    PartnerFunctionalArea,
    PartnerProfitCenter,
    PaymentServiceTransactionType,
    PaymentService,
    PostedBy,
    PostingDate,
    ProfitCenterTransactionType,
    ProfitCenter,
    ReferenceArea,
    ReferenceKey,
    ReverseDocumentIndicator,
    ReversedDocumentAccountingDocumentItem,
    ReversedDocumentAccountingDocument,
    ReversedDocumentAccountingPeriod,
    ReversedDocumentAccountingUnit,
    ReversedDocumentFiscalYear,
    SalesOrderItemTransactionType,
    SalesOrderItem,
    SalesOrderTransactionType,
    SalesOrder,
    TransactionCurrency,
    UserName,
    VatAmountOfAccountingAreaCurrency,
    VatAmountOfAccountingUnitCurrency,
    VatAmountOfTransactionCurrency,
    VatBaseAmountOfAccountingAreaCurrency,
    VatBaseAmountOfAccountingUnitCurrency,
    VatBaseAmountOfTransactionCurrency,
    VatCode,
    VendorTransactionType,
    Vendor,
    WbsElementTransactionType,
    WbsElement
  }

  doctest AccountingAreaCurrency, import: true
  doctest AccountingArea, import: true
  doctest AccountingDocumentItemNumber, import: true
  doctest AccountingDocumentNumberRangeCode, import: true
  doctest AccountingDocumentNumber, import: true
  doctest AccountingPeriod, import: true
  doctest AccountingUnitCurrency, import: true
  doctest AccountingUnit, import: true
  doctest AmountInAccountingAreaCurrency, import: true
  doctest AmountInAccountingUnitCurrency, import: true
  doctest AmountInTransactionCurrency, import: true
  doctest Bank, import: true
  doctest ClearingDocumentAccountingDocumentItem, import: true
  doctest ClearingDocumentAccountingDocument, import: true
  doctest ClearingDocumentAccountingPeriod, import: true
  doctest ClearingDocumentAccountingUnit, import: true
  doctest ClearingDocumentFiscalYear, import: true
  doctest ClearingDocumentIndicator, import: true
  doctest CostCenterTransactionType, import: true
  doctest CostCenter, import: true
  doctest Currency, import: true
  doctest CustomerTransactionType, import: true
  doctest Customer, import: true
  doctest DateOfExchangeRateToAccountingAreaCurrency, import: true
  doctest DateOfExchangeRateToAccountingUnitCurrency, import: true
  doctest DebitCredit, import: true
  doctest DocumentDate, import: true
  doctest DocumentType, import: true
  doctest EnteredAt, import: true
  doctest EnteredBy, import: true
  doctest EntryDate, import: true
  doctest ExchangeRateToAccountingAreaCurrency, import: true
  doctest ExchangeRateToAccountingUnitCurrency, import: true
  doctest ExchangeRateTypeToAccountingAreaCurrency, import: true
  doctest ExchangeRateTypeToAccountingUnitCurrency, import: true
  doctest FiscalYear, import: true
  doctest FixedAssetTransactionType, import: true
  doctest FixedAsset, import: true
  doctest FunctionalAreaTransactionType, import: true
  doctest FunctionalArea, import: true
  doctest GeneralLedgerAccountTransactionType, import: true
  doctest GeneralLedgerAccount, import: true
  doctest Language, import: true
  doctest Zip, import: true
  doctest Material, import: true
  doctest OffsettingBank, import: true
  doctest OffsettingCostCenter, import: true
  doctest OffsettingCustomer, import: true
  doctest OffsettingFixedAsset, import: true
  doctest OffsettingFunctionalArea, import: true
  doctest OffsettingGeneralLedgerAccount, import: true
  doctest OffsettingMaterial, import: true
  doctest OffsettingOrder, import: true
  doctest OffsettingPaymentService, import: true
  doctest OffsettingProfitCenter, import: true
  doctest OffsettingVendor, import: true
  doctest OffsettingWbsElement, import: true
  doctest OrderTransactionType, import: true
  doctest Order, import: true
  doctest PartnerAccountingUnit, import: true
  doctest PartnerCostCenter, import: true
  doctest PartnerFunctionalArea, import: true
  doctest PartnerProfitCenter, import: true
  doctest PaymentServiceTransactionType, import: true
  doctest PaymentService, import: true
  doctest PostedBy, import: true
  doctest PostingDate, import: true
  doctest ProfitCenterTransactionType, import: true
  doctest ProfitCenter, import: true
  doctest ReferenceArea, import: true
  doctest ReferenceKey, import: true
  doctest ReverseDocumentIndicator, import: true
  doctest ReversedDocumentAccountingDocumentItem, import: true
  doctest ReversedDocumentAccountingDocument, import: true
  doctest ReversedDocumentAccountingPeriod, import: true
  doctest ReversedDocumentAccountingUnit, import: true
  doctest ReversedDocumentFiscalYear, import: true
  doctest SalesOrderItemTransactionType, import: true
  doctest SalesOrderItem, import: true
  doctest SalesOrderTransactionType, import: true
  doctest SalesOrder, import: true
  doctest TransactionCurrency, import: true
  doctest UserName, import: true
  doctest VatAmountOfAccountingAreaCurrency, import: true
  doctest VatAmountOfAccountingUnitCurrency, import: true
  doctest VatAmountOfTransactionCurrency, import: true
  doctest VatBaseAmountOfAccountingAreaCurrency, import: true
  doctest VatBaseAmountOfAccountingUnitCurrency, import: true
  doctest VatBaseAmountOfTransactionCurrency, import: true
  doctest VatCode, import: true
  doctest VendorTransactionType, import: true
  doctest Vendor, import: true
  doctest WbsElementTransactionType, import: true
  doctest WbsElement, import: true
end
