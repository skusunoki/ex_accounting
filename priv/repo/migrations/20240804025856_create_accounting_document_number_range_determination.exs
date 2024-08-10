defmodule ExAccounting.Repo.Migrations.CreateAccountingDocumentNumberRangeDetermination do
  use Ecto.Migration

  def change do
    create table(:accounting_document_number_range_determination) do
      add :accounting_unit, :string
      add :document_type, :string
      add :number_range_code, :string
    end

    create unique_index(:accounting_document_number_range_determination,
    [ :accounting_unit,
      :document_type ])
  end
end
