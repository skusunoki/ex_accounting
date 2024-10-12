defmodule ExAccounting.Repo.Migrations.AddAccountingAreaAttrId do
  use Ecto.Migration

  def change do
    create table(:accounting_areas) do
      add :accounting_area, :string
      add :accounting_area_currency, :string
    end

    alter(table(:accounting_units)) do
      add :accounting_area_attr_id, references(:accounting_areas)
    end
  end
end
