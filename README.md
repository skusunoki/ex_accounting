# ExAccounting

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_accounting` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_accounting, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ex_accounting>.

## General Ledger Data Items Aggregation

```mermaid
classDiagram
  class AccountingDocumentItem{ }
  class AccountingDocumentHeader{ }
  class ReverseDocument{ }
  class ClearingDocument{ }
  AccountingDocumentItem o--> AccountingDocumentHeader
  AccountingDocumentItem o--> ReverseDocument
  AccountingDocumentItem o--> ClearingDocument

```

| Object | Data Item |
|--------|-----------|
| Root (AccountingDocumentItem)   | FiscalYear |
| Root (AccountingDocumentItem)   | AccountingArea |
| Root (AccountingDocumentItem)   | AccountingDocumentNumber |
| Root (AccountingDocumentItem)   | AccountingUnit |
| Root (AccountingDocumentItem)   | AccountingDocumentItemNumber |
| Root (AccountingDocumentItem) | DebitCredit |
| AccountingDocumentHeader | DocumentType |
| AccountingDocumentHeader | PostingDate |
| AccountingDocumentHeader   | AccountingPeriod |
| AccountingDocumentHeader | DocumentDate |
| AccountingDocumentHeader | EntryDate |
| AccountingDocumentHeader | EnteredAt |
| AccountingDocumentHeader | EnteredBy |
| AccountingDocumentHeader | PostedBy |
| ReverseDocument | ReverseDocumentIndicator |
| ReverseDocument | ReversedDocumentAccountingUnit |
| ReverseDocument | ReversedDocumentFiscalYear |
| ReverseDocument | ReversedDocumentAccountingDocument |
| ReverseDocument | ReversedDocumentAccountingDocumentItem |
| ReverseDocument | ReversedDocumentAccountingPeriod |
| ClearingDocument | ClearingDocumentIndicator |
| ClearingDocument | ClearedDocumentAccountingUnit |
| ClearingDocument | ClearingDocumentFiscalYear |
| ClearingDocument | ClearedDocumentAccountingDocument |
| ClearingDocument | ClearedDocumentAccountingDocumentItem |
| ClearingDocument | ClearedDocumentAccountingPeriod |
| HeaderReference | ReferenceArea |
| HeaderReference | ReferenceKey |
| GeneralLedgerTransaction | GeneralLedgerAccountTransactionType |
| GeneralLedgerTransaction | GeneralLedgerAccount |
| VendorTransaction | VendorTransactionType |
| VendorTransaction | Vendor |
| CustomerTransaction | CustomerTransactionType |
| CustomerTransaction | Customer |
| FixedAssetTransaction | FixedAssetTransactionType |
| FixedAssetTransaction | FixedAsset |
| MaterialTransaction | MaterialTransactionType |
| MaterialTransaction | Material |
| BankTransaction | BankTransactionType |
| BankTransaction | Bank |
| PaymentServiceTransaction | PaymentServiceTransactionType |
| PaymentServiceTransaction | PaymentService |
| ProfitCenterTransaction | ProfitCenterTransactionType |
| ProfitCenterTransaction | ProfitCenter |
| FunctionalAreaTransaction | FunctionalAreaTransactionType |
| FunctionalAreaTransaction | FunctionalArea |
| CostCenterTransaction | CostCenterTransactionType |
| CostCenterTransaction | CostCenter |
| OrderTransaction | OrderTransactionType |
| OrderTransaction | Order |
| WBSElementTransaction | WBSElementTransactionType |
| WBSElementTransaction  | WBSElement |
| SalesOrderTransaction | SalesOrderTransactionType |
| SalesOrderTransaction | SalesOrder |
| SalesOrderItemTransaction | SalesOrderItemTransactionType |
| SalesOrderItemTransaction | SalesOrderItem |
| PartnerAccount | PartnerAccountingUnit |
| PartnerAccount | PartnerProfitCenter |
| PartnerAccount | PartnerCostCenter |
| PartnerAccount | PartnerFunctionalArea |
| AccountingUnitCurrencyAmount | AccountingUnitCurrency |
| AccountingUnitCurrencyAmount | AmountInAccountingUnitCurrency |
| AccountingUnitCurrencyAmount | ExchangeRateTypeToAccountingUnitCurrency |
| AccountingUnitCurrencyAmount | ExchangeRateToAccountingUnitCurrency |
| AccountingUnitCurrencyAmount | DateOfExchangeRateToAccountingUnitCurrency |
| TransactionCurrencyAmount | TransactionCurrency |
| TransactionCurrencyAmount | AmountInTransactionUnitCurrency |
| AccountingAreaCurrency | AccountingAreaCurrency |
| AccountingAreaCurrency | AmountInAccountingAreaCurrency |
| AccountingAreaCurrencyAmount | ExchangeRateTypeToAccountingAreaCurrency |
| AccountingAreaCurrencyAmount | ExchangeRateToAccountingAreaCurrency |
| AccountingAreaCurrencyAmount | DateOfExchangeRateToAccountingAreaCurrency |
| OffsettingItem | OffsettingGeneralLedgerAccount |
| OffsettingItem | OffsettingVendor |
| OffsettingItem | OffsettingCustomer |
| OffsettingItem | OffsettingFixedAsset |
| OffsettingItem | OffsettingMaterial |
| OffsettingItem | OffsettingBank |
| OffsettingItem | OffsettingPaymentService |
| OffsettingItem | OffsettingProfitCenter |
| OffsettingItem | OffsettingCostCenter |
| OffsettingItem | OffsettingFunctionalArea |
| OffsettingItem | OffsettingWBSElement |
| VAT | VATCode |
| VAT | VATAmountOfAccountingUnitCurrency |
| VAT | VATAmountOfTransactionUnitCurrency |
| VAT | VATAmountOfAccountingAreaCurrency |
| VAT | VATBaseAmountOfAccountingUnitCurrency |
| VAT | VATBaseAmountOfTransactionUnitCurrency |
| VAT | VATBaseAmountOfAccountingAreaCurrency |


## General Ledger 
