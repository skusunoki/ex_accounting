defmodule ExAccounting.Repo do
  use Ecto.Repo,
    otp_app: :ex_accounting,
    adapter: Ecto.Adapters.Postgres

  @doc """
  Update or insert based on the first element of the tuple of argument.
  """
  @spec upsert({:update, any()}) :: {:error, any} | {:ok, any}
  @spec upsert({:insert, any()}) :: {:error, any} | {:ok, any}
  def upsert({:insert, changeset}) do
    insert(changeset)
  end

  def upsert({:update, changeset}) do
    update(changeset)
  end
end
