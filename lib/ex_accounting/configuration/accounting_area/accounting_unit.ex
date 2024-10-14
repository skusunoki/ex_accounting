defmodule ExAccounting.Configuration.AccountingArea.AccountingUnit do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer() | nil,
          accounting_unit: ExAccounting.Elem.AccountingUnit.t() | nil,
          accounting_unit_currency: ExAccounting.Elem.AccountingUnitCurrency.t() | nil
        }

  schema "accounting_units" do
    field(:accounting_unit, ExAccounting.Elem.AccountingUnit)
    field(:accounting_unit_currency, ExAccounting.Elem.AccountingUnitCurrency)
    belongs_to(:accounting_area, ExAccounting.Configuration.AccountingArea)

    has_many(
      :accounting_document_number_range_determinations,
      ExAccounting.Configuration.AccountingArea.AccountingDocumentNumberRangeDetermination,
      foreign_key: :accounting_unit,
      references: :accounting_unit
    )
  end

  def changeset(accounting_unit, params) do
    accounting_unit
    |> cast(params, [
      :accounting_unit,
      :accounting_unit_currency
    ])
    |> cast_assoc(:accounting_document_number_range_determinations,
      with:
        &ExAccounting.Configuration.AccountingArea.AccountingDocumentNumberRangeDetermination.changeset/2
    )
    |> validate_required([:accounting_unit, :accounting_unit_currency])
    |> unique_constraint([:accounting_unit])
  end
end
