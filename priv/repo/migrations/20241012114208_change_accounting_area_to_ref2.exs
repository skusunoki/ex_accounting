defmodule ExAccounting.Repo.Migrations.ChangeAccountingAreaToRef2 do
  use Ecto.Migration

  def change do
    alter(table(:accounting_units)) do
      remove :accounting_area_id, references(:accounting_areas)
      add :accounting_area, references(:accounting_areas)
    end
  end
end
