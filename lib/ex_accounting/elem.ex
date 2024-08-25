defmodule ExAccounting.Elem do
  @moduledoc """
  Aliasing elements for casting.
  """
  alias ExAccounting.Elem.{
    AccountingArea,
    AccountingDocumentItemNumber,
    AccountingDocumentNumberRangeCode,
    AccountingDocumentNumber,
    AccountingPeriod,
    AccountingUnit,
    DebitCredit,
    DocumentDate,
    DocumentType,
    EnteredAt,
    EnteredBy,
    EntryDate,
    FiscalYear,
    PostedBy,
    PostingDate,
    ReverseDocumentIndicator
  }

  defdelegate to_accounting_area(term), to: AccountingArea, as: :cast
  defdelegate to_accounting_document_item_number(term), to: AccountingDocumentItemNumber, as: :cast
  defdelegate to_accounting_document_number_range_code(term), to: AccountingDocumentNumberRangeCode, as: :cast
  defdelegate to_accounting_document_number(term), to: AccountingDocumentNumber, as: :cast
  defdelegate to_accounting_period(term), to: AccountingPeriod, as: :cast
  defdelegate to_accounting_unit(term), to: AccountingUnit, as: :cast
  defdelegate to_debit_credit(term), to: DebitCredit, as: :cast
  defdelegate to_document_date(term), to: DocumentDate, as: :cast
  defdelegate to_document_type(term), to: DocumentType, as: :cast
  defdelegate to_entered_at(term), to: EnteredAt, as: :cast
  defdelegate to_entered_by(term), to: EnteredBy, as: :cast
  defdelegate to_entry_date(term), to: EntryDate, as: :cast
  defdelegate to_fiscal_year(term), to: FiscalYear, as: :cast
  defdelegate to_posted_by(term), to: PostedBy, as: :cast
  defdelegate to_posting_date(term), to: PostingDate, as: :cast
  defdelegate to_reverse_document_indicator(term), to: ReverseDocumentIndicator, as: :cast


end
