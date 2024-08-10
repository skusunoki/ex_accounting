defmodule ExAccounting.Repo.Migrations.AddUniqueConstraintOfUserNameInUsers do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:user_name])
  end
end
