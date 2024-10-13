defmodule ExAccounting.Repo.Migrations.UniqueConstraintOfAccountingArea do
  use Ecto.Migration

  def change do
    drop(table(:accounting_units))
    drop(table(:accounting_areas))
    create(table(:accounting_areas)) do
      add :accounting_area, :string
      add :accounting_area_currency, :string
    end
    create(table(:accounting_units)) do
      add :accounting_unit, :string
      add :accounting_unit_currency, :string
      add :accounting_area, references(:accounting_areas)
    end
    create(unique_index(:accounting_areas, [:accounting_area]))
    create(unique_index(:accounting_units, [:accounting_unit]))
  end


end
