defmodule ExAccounting.Repo do
  @moduledoc false

  use Ecto.Repo,
    otp_app: :ex_accounting,
    adapter: Ecto.Adapters.Postgres

  @doc """
  Update or insert based on the first element of the tuple of argument.
  """
  @spec upsert(
          {:update, changeset :: Ecto.Changeset.t()}
          | {:insert, changeset :: Ecto.Changeset.t()}
        ) ::
          {:error, Ecto.Changeset.t()} | {:ok, Ecto.Changeset.t()}
  def upsert({:insert, changeset}) do
    insert(changeset)
  end

  def upsert({:update, changeset}) do
    update(changeset)
  end
end
