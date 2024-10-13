defmodule ExAccounting.Repo.Migrations.FixAssociationOfAccountingDocumentNumberRangeDeterminations do
  use Ecto.Migration

  def change do
    alter table(:accounting_document_number_range_determinations) do
      remove :accounting_area_id, references(:accounting_areas)
    end
  end
end
