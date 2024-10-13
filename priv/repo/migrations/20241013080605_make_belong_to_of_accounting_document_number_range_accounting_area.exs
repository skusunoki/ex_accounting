defmodule ExAccounting.Repo.Migrations.MakeBelongToOfAccountingDocumentNumberRangeAccountingArea do
  use Ecto.Migration

  def change do
    alter table(:accounting_document_number_ranges) do
      add :accounting_area_id, references(:accounting_areas)
    end

    drop index(:accounting_document_number_ranges,
    [ :number_range_code])

    create unique_index(:accounting_document_number_ranges,
    [ :number_range_code,
      :accounting_area_id ])
  end
end
