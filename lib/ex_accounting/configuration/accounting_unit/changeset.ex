defmodule ExAccounting.Configuration.AccountingUnit.Changeset do
  import Ecto.Changeset

  def changeset(accounting_unit, params \\ %{}) do
    accounting_unit
    |> cast(params, [
      :accounting_unit,
      :accounting_unit_currency
    ])
    |> validate_required([:accounting_unit, :accounting_unit_currency])
    |> unique_constraint([:accounting_unit])
  end
end
