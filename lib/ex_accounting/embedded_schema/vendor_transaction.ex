defmodule ExAccounting.EmbeddedSchema.VendorTransaction do
  use Ecto.Schema

  embedded_schema do
    field(:accounting_area, ExAccounting.Elem.AccountingArea)
    field(:accounting_unit, ExAccounting.Elem.AccountingUnit)
    field(:profit_center, ExAccounting.Elem.ProfitCenter)
    field(:fiscal_year, ExAccounting.Elem.FiscalYear)
    field(:accounting_period, ExAccounting.Elem.AccountingPeriod)
    field(:posting_date, ExAccounting.Elem.PostingDate)
    field(:vendor, ExAccounting.Elem.Vendor)
    field(:vendor_transaction_type, ExAccounting.Elem.VendorTransactionType)
    field(:debit_credit, ExAccounting.Elem.DebitCredit)
    field(:accounting_document_number, ExAccounting.Elem.AccountingDocumentNumber)
    field(:accounting_document_item_number, ExAccounting.Elem.AccountingDocumentItemNumber)
    embeds_one(:transaction_value, ExAccounting.EmbeddedSchema.Money)
    embeds_one(:accounting_area_value, ExAccounting.EmbeddedSchema.Money)
    embeds_one(:accounting_unit_value, ExAccounting.EmbeddedSchema.Money)
  end
end
