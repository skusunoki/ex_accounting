defmodule ExAccounting.EmbeddedSchema.TaxTransaction do
  @moduledoc """
  _Tax Trasaction_ is a aspect of a journal entry that represents a recognition of a tax incurred or paid.
  """
  use Ecto.Schema

  embedded_schema do
    field(:accounting_area, ExAccounting.Elem.AccountingArea)
    field(:accounting_unit, ExAccounting.Elem.AccountingUnit)
    field(:profit_center, ExAccounting.Elem.ProfitCenter)
    field(:fiscal_year, ExAccounting.Elem.FiscalYear)
    field(:accounting_period, ExAccounting.Elem.AccountingPeriod)
    field(:posting_date, ExAccounting.Elem.PostingDate)
    field(:tax_code, ExAccounting.Elem.VatCode)
    field(:debit_credit, ExAccounting.Elem.DebitCredit)
    field(:accounting_document_number, ExAccounting.Elem.AccountingDocumentNumber)
    field(:accounting_document_item_number, ExAccounting.Elem.AccountingDocumentItemNumber)
    embeds_one(:vat_transaction_amount, ExAccounting.EmbeddedSchema.Money)
    embeds_one(:vat_transaction_base_amount, ExAccounting.EmbeddedSchema.Money)
    embeds_one(:vat_accounting_area_amount, ExAccounting.EmbeddedSchema.Money)
    embeds_one(:vat_accounting_area_base_amount, ExAccounting.EmbeddedSchema.Money)
    embeds_one(:vat_accounting_unit_amount, ExAccounting.EmbeddedSchema.Money)
    embeds_one(:vat_accounting_unit_base_amount, ExAccounting.EmbeddedSchema.Money)
  end
end
