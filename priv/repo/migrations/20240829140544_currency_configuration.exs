defmodule ExAccounting.Repo.Migrations.Currency do
  use Ecto.Migration

  def change do
    create table(:currency_configurations) do
      add :currency, :string, primary_key: true
      end
  end
end
