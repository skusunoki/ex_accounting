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
    ReverseDocumentIndicator,
    ReversedDocumentAccountingUnit,
    ReversedDocumentFiscalYear,
    ReversedDocumentAccountingDocument
  }

  defdelegate to_accounting_area(term), to: AccountingArea, as: :cast

  defdelegate to_accounting_document_item_number(term),
    to: AccountingDocumentItemNumber,
    as: :cast

  defdelegate to_accounting_document_number_range_code(term),
    to: AccountingDocumentNumberRangeCode,
    as: :cast

  def to_accounting_document_number(%ReversedDocumentAccountingDocument{} = term),
    do: ReversedDocumentAccountingDocument.to_accounting_document_number(term)

  defdelegate to_accounting_document_number(term), to: AccountingDocumentNumber, as: :cast
  defdelegate to_accounting_period(term), to: AccountingPeriod, as: :cast
  defdelegate to_accounting_unit(term), to: AccountingUnit, as: :cast
  defdelegate to_debit_credit(term), to: DebitCredit, as: :cast
  defdelegate to_document_date(term), to: DocumentDate, as: :cast
  defdelegate to_document_type(term), to: DocumentType, as: :cast
  defdelegate to_entered_at(term), to: EnteredAt, as: :cast
  defdelegate to_entered_by(term), to: EnteredBy, as: :cast
  defdelegate to_entry_date(term), to: EntryDate, as: :cast

  def to_fiscal_year(%ReversedDocumentFiscalYear{} = term),
    do: ReversedDocumentFiscalYear.to_fiscal_year(term)

  defdelegate to_fiscal_year(term), to: FiscalYear, as: :cast
  defdelegate to_posted_by(term), to: PostedBy, as: :cast
  defdelegate to_posting_date(term), to: PostingDate, as: :cast
  defdelegate to_reverse_document_indicator(term), to: ReverseDocumentIndicator, as: :cast

  defdelegate to_reversed_document_accounting_unit(term),
    to: ReversedDocumentAccountingUnit,
    as: :cast

  defdelegate to_reversed_document_fiscal_year(term),
    to: ReversedDocumentFiscalYear,
    as: :cast

  defdelegate to_reversed_document_accounting_document(term),
    to: ReversedDocumentAccountingDocument,
    as: :cast

  def dump(%AccountingArea{} = term), do: AccountingArea.dump(term)
  def dump(%AccountingDocumentItemNumber{} = term), do: AccountingDocumentItemNumber.dump(term)

  def dump(%AccountingDocumentNumberRangeCode{} = term),
    do: AccountingDocumentNumberRangeCode.dump(term)

  def dump(%AccountingDocumentNumber{} = term), do: AccountingDocumentNumber.dump(term)
  def dump(%AccountingPeriod{} = term), do: AccountingPeriod.dump(term)
  def dump(%AccountingUnit{} = term), do: AccountingUnit.dump(term)
  def dump(%DebitCredit{} = term), do: DebitCredit.dump(term)
  def dump(%DocumentDate{} = term), do: DocumentDate.dump(term)
  def dump(%DocumentType{} = term), do: DocumentType.dump(term)
  def dump(%EnteredAt{} = term), do: EnteredAt.dump(term)
  def dump(%EnteredBy{} = term), do: EnteredBy.dump(term)
  def dump(%EntryDate{} = term), do: EntryDate.dump(term)
  def dump(%FiscalYear{} = term), do: FiscalYear.dump(term)
  def dump(%PostedBy{} = term), do: PostedBy.dump(term)
  def dump(%PostingDate{} = term), do: PostingDate.dump(term)
  def dump(%ReverseDocumentIndicator{} = term), do: ReverseDocumentIndicator.dump(term)

  def dump(%ReversedDocumentAccountingUnit{} = term),
    do: ReversedDocumentAccountingUnit.dump(term)

  def dump(%ReversedDocumentFiscalYear{} = term), do: ReversedDocumentFiscalYear.dump(term)

  def dump(%ReversedDocumentAccountingDocument{} = term),
    do: ReversedDocumentAccountingDocument.dump(term)
end
