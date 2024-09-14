defmodule ExAccounting.Repo.Migrations.NewLearningSchemaThreeVectors do
  use Ecto.Migration

  def change do
    create table(:three_vectors) do
      add :position1_x, :integer
      add :position1_y, :integer
      add :position2_x, :integer
      add :position2_y, :integer
      add :position3_x, :integer
      add :position3_y, :integer
    end
  end
end
