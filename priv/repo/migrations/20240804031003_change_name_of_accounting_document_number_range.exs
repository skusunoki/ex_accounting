defmodule ExAccounting.Repo.Migrations.ChangeNameOfAccountingDocumentNumberRange do
  use Ecto.Migration

  def change do
    drop_if_exists index(:accounting_document_number_range,[
      :number_range_code,
      :accounting_to_fiscal_year
    ])
    drop_if_exists table(:accounting_document_number_range)

    drop_if_exists index(:accounting_document_number_range_determination,[
      :accounting_unit,
      :document_type
    ])
    drop_if_exists table(:accounting_document_number_range_determination)

    create table(:accounting_document_number_range_determinations) do
      add :accounting_unit, :string
      add :document_type, :string
      add :to_fiscal_year, :integer
      add :number_range_code, :string
    end

    create unique_index(:accounting_document_number_range_determinations,
    [ :accounting_unit,
      :document_type,
      :to_fiscal_year ])

    create table(:accounting_document_number_ranges) do
      add :number_range_code, :string
      add :accounting_document_number_from, :integer
      add :accounting_document_number_to, :integer
    end

    create unique_index(:accounting_document_number_ranges,
    [ :number_range_code ])

    create table(:current_accounting_document_numbers) do
      add :number_range_code, :string
      add :current_document_number, :integer
    end

    create unique_index(:current_accounting_document_numbers,
    [ :number_range_code ])

  end
end
