defmodule ExAccounting.Configuration.AccountingDocumentNumberRangeDetermination do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounting_document_number_range_determinations" do
    field(:accounting_unit, ExAccounting.Elem.AccountingUnit)
    field(:document_type, ExAccounting.Elem.DocumentType)
    field(:to_fiscal_year, ExAccounting.Elem.FiscalYear)
    field(:number_range_code, ExAccounting.Elem.AccountingDocumentNumberRangeCode)
  end

  def changeset(accounting_document_number_range_determination, params \\ %{}) do
    accounting_document_number_range_determination
    |> cast(params, [:accounting_unit, :document_type, :to_fiscal_year, :number_range_code])
    |> unique_constraint([:accounting_unit, :document_type, :to_fiscal_year])
  end
end
