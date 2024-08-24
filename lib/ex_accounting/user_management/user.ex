defmodule ExAccounting.UserManagement.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:user_name, :string)
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
