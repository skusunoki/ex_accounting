defmodule ExAccounting.Repo.Migrations.ChangeDatatypeOfAccountingAreaFromJsonToVarchar do
  use Ecto.Migration

  def change do
    execute "ALTER TABLE accounting_document_items ALTER COLUMN accounting_area TYPE varchar(255)",
        "ALTER TABLE accounting_document_items ALTER COLUMN accounting_area TYPE json USING accounting_area::jsonb;"
  end
end
