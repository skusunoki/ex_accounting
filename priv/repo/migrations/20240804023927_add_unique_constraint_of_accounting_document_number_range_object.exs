defmodule ExAccounting.Repo.Migrations.AddUniqueConstraintOfAccountingDocumentNumberRangeObject do
  use Ecto.Migration

  def change do
    alter table(:accounting_document_number_range) do
      remove :accounting_unit, :string, default: nil
      add_if_not_exists :number_range_code, :string
      add_if_not_exists :accounting_to_fiscal_year, :integer
      add_if_not_exists :accounting_document_number_from, :integer
      add_if_not_exists :accounting_document_number_to, :integer
      remove :current_accounting_document_number, :integer, default: nil
    end

    create unique_index(:accounting_document_number_range,
    [ :number_range_code,
      :accounting_to_fiscal_year ])
  end
end
