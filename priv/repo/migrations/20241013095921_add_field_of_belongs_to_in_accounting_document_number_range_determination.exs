defmodule ExAccounting.Repo.Migrations.AddFieldOfBelongsToInAccountingDocumentNumberRangeDetermination do
  use Ecto.Migration

  def change do
    alter table(:accounting_document_number_range_determinations) do
      add :belongs_to, references(:accounting_areas)
    end
  end
end
