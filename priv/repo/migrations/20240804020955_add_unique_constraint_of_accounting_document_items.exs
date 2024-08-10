defmodule ExAccounting.Repo.Migrations.AddUniqueConstraintOfAccountingDocumentItems do
  use Ecto.Migration

  def change do
    create unique_index(:accounting_document_items,
      [ :fiscal_year,
        :accounting_document_number,
        :accounting_unit,
        :accounting_document_item_number ])
  end
end
