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
    |> validate_required([:accounting_unit, :document_type, :to_fiscal_year, :number_range_code])
    |> unique_constraint([:accounting_unit, :document_type, :to_fiscal_year])
  end

  @doc """
  Determines the accounting document number range code by the Accounting Unit, Document Type, and Fiscal Year of the document.

  - Configured Accounting Unit should be identical to the Accounting Unit of the document.
  - Configured Document Type should be identical to the Document Type of the document.
  - Configured Fiscal Year should be larger than or equal to the Fiscal Year of the document. Used minimum Fiscal Year to determine the number range code.
  """
  def determine(
        accounting_unit,
        document_type,
        to_fiscal_year,
        repo \\ fn -> ExAccounting.Repo end
      ) do
    with q =
           from(m in __MODULE__,
             where:
               m.accounting_unit == ^accounting_unit and
                 m.document_type == ^document_type and
                 m.to_fiscal_year >= ^to_fiscal_year
           ),
         result when result != [] <-
           q
           |> repo.().all() do
      result
      |> Enum.filter(fn r -> r.to_fiscal_year.fiscal_year >= to_fiscal_year.fiscal_year end)
      |> Enum.sort(fn r, l -> r.to_fiscal_year.fiscal_year < l.to_fiscal_year.fiscal_year end)
      |> tap(&IO.inspect/1)
      |> Enum.at(0)
      |> Map.get(:number_range_code)
    else
      _ -> {:error, "Accounting Document Number Range Determination not found"}
    end
  end
end
