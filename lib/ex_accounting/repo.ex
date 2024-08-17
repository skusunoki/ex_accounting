defmodule ExAccounting.Repo do
  use Ecto.Repo,
    otp_app: :ex_accounting,
    adapter: Ecto.Adapters.Postgres

  @spec upsert(any) :: {:error, any} | {:ok, any}
  def upsert({:insert, changeset}) do
    insert(changeset)
  end

  def upsert({:update, changeset}) do
    update(changeset)
  end
end
