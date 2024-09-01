defmodule ExAccounting.Repo.Migrations.AddCentFactor do
  use Ecto.Migration

  def change do
    alter table(:currency_configurations) do
      add :cent_factor, :integer
    end
  end
end
