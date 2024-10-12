defmodule ExAccounting.Repo.Migrations.CreateAccountingUnits do
  use Ecto.Migration

  def change do
    create table(:accounting_units) do
      add :accounting_unit, :string
      add :accounting_unit_currency, :string
      add :accounting_area, :string
  end
  end
end
