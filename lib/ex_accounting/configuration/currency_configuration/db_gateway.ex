defmodule ExAccounting.Configuration.CurrencyConfiguration.DbGateway do
  use Ecto.Schema
  import Ecto.Changeset

  schema "currency_configurations" do
    field(:currency, ExAccounting.Money.Currency, primary_key: true)
  end

  def read() do
    __MODULE__
    |> ExAccounting.Repo.all()
    |> Enum.map( fn x -> x.currency end)
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
