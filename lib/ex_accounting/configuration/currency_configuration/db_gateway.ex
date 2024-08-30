defmodule ExAccounting.Configuration.CurrencyConfiguration.DbGateway do
  import Ecto.Changeset

  def read_from_db() do
    ExAccounting.Configuration.CurrencyConfiguration
    |> ExAccounting.Repo.all()
    |> Enum.map(& &1.currency.currency)
  end

  def changeset(currency_configuration, params \\ %{}) do
    currency_configuration
    |> cast(params, [:currency])
  end

  def insert(currency) do
    %ExAccounting.Configuration.CurrencyConfiguration{}
    |> changeset(%{currency: currency})
    |> ExAccounting.Repo.insert()
  end
end
