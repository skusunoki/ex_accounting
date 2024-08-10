defmodule ExAccounting.Repo.Migrations.CreateAccountingDocumentNumberRangeObject do
  use Ecto.Migration

  def change do
    create table(:accounting_document_number_range) do
      add :accounting_unit, :string
      add :accounting_to_fiscal_year, :integer
      add :accounting_document_number_from, :integer
      add :accounting_document_number_to, :integer
      add :current_accounting_document_number, :integer
  end
end
end
