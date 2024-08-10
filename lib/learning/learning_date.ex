defmodule Learning.LearningDate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "learning_dates" do
    field(:date, :date)
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:date])
  end
end
