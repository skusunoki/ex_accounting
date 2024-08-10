defmodule ExAccounting.Repo.Migrations.ChangeDocumentNumberRangeType do
  use Ecto.Migration

  def change do
    alter table(:accounting_document_number_ranges) do
      modify :accounting_document_number_from, :bigint
      modify :accounting_document_number_to, :bigint
    end

    alter table(:accounting_document_items) do
      modify :accounting_document_number, :bigint
      modify :reverse_document_accounting_document, :bigint
      modify :clearing_document_accounting_document, :bigint
    end

    alter table(:current_accounting_document_numbers) do
      modify :current_document_number, :bigint
    end
  end
end
