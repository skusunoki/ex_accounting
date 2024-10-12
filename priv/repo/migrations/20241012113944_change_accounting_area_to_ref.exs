defmodule ExAccounting.Repo.Migrations.ChangeAccountingAreaToRef do
  use Ecto.Migration

  def change do
    alter(table(:accounting_units)) do
    remove :accounting_area_id, references(:accounting_areas)
    remove :accounting_area, :string
    add :accounting_area_id, references(:accounting_areas)
    end
  end
end
