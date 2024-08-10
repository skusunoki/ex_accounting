defmodule ExAccounting.Repo.Migrations.CreateLearningDates do
  use Ecto.Migration

  def change do
    create table(:learning_dates) do
    add :date, :date
    end
  end
end
