defmodule ExAccounting.Repo.Migrations.AddFieldOfBelongsToInAccountingDocumentNumberRangeDeterminatio2 do
  use Ecto.Migration

  def change do
    alter table(:accounting_document_number_range_determinations) do
      remove :belongs_to, references(:accounting_areas)
      add :accounting_area_id, references(:accounting_areas)
    end
  end
end
