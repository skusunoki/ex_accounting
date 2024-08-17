defmodule ExAccounting.Repo.Migrations.CreateLearningCustomType do
  use Ecto.Migration

  def change do
      execute "ALTER TABLE accounting_document_items ALTER COLUMN accounting_area TYPE json USING accounting_area::jsonb;",
              "ALTER TABLE accounting_document_items ALTER COLUMN accounting_area TYPE varchar(255)"

  end
end
