defmodule ExAccounting.Configuration.AccountingDocumentNumberRangeDetermination do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

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

  def determine(accounting_unit, document_type, to_fiscal_year) do
    with q =
           from(m in __MODULE__,
             where:
               m.accounting_unit == ^accounting_unit and
                 m.document_type == ^document_type and
                 m.to_fiscal_year >= ^to_fiscal_year
           ),
         result =
           q
           |> tap(&IO.inspect(&1))
           |> ExAccounting.Repo.all()
           |> Enum.sort(fn r, l -> r.to_fiscal_year < l.to_fiscal_year end)
           |> Enum.at(0) do
      result.number_range_code
    end
  end
end
