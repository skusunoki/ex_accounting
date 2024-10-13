defmodule ExAccounting.Configuration.AccountingArea.Changeset do
  import Ecto.Changeset

  def add_accounting_area(%{
        accounting_area: accounting_area,
        accounting_area_currency: accounting_area_currency
      }) do
    %ExAccounting.Configuration.AccountingArea{}
    |> changeset(%{
      accounting_area: accounting_area,
      accounting_area_currency: accounting_area_currency,
      accounting_units: []
    })
    |> unique_constraint([:accounting_area])
  end

  def changeset(accounting_area, params) do
    accounting_area
    |> cast(params, [:accounting_area, :accounting_area_currency])
    |> validate_required([:accounting_area, :accounting_area_currency])
    |> cast_assoc(:accounting_units,
      with: &ExAccounting.Configuration.AccountingArea.AccountingUnit.changeset/2
    )
    |> cast_assoc(:accounting_document_number_ranges,
      with: &ExAccounting.Configuration.AccountingArea.AccountingDocumentNumberRange.changeset/2
    )
  end
end
