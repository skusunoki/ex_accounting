defmodule ExAccounting.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:user_name, :string)
    belongs_to(:individual_entity, ExAccounting.Schema.IndividualEntity)
  end

  @doc """
  Makes the changeset for the user.
  """
  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:user_name])
    |> unique_constraint(:user_name)
  end
end
