defmodule ExAccounting.Configuration.CurrencyConfiguration.DbGateway do
  use Ecto.Schema
  import Ecto.Changeset

  schema "currency_configurations" do
    field(:currency, ExAccounting.Money.Currency, primary_key: true)
    field(:cent_factor, :integer)
  end

  def read() do
    __MODULE__
    |> ExAccounting.Repo.all()
    |> Enum.map(fn x -> %{currency: x.currency, cent_factor: x.cent_factor} end)
  end

  def changeset(currency_configuration, params \\ %{}) do
    currency_configuration
    |> cast(params, [:currency, :cent_factor])
  end

  def insert(currency, cent_factor) do
    %__MODULE__{}
    |> changeset(%{currency: currency, cent_factor: cent_factor})
    |> ExAccounting.Repo.insert()
  end

  def update(currency, cent_factor) do
    __MODULE__
    |> ExAccounting.Repo.get_by(currency: currency)
    |> changeset(%{cent_factor: cent_factor})
    |> ExAccounting.Repo.update()
  end

  def save(server) do
    with db = read() do

    result = server
    |> Enum.filter(fn x -> Enum.any?(db, fn y -> x.currency == y.currency end) end)
    |> Enum.map(fn x -> update(x.currency, x.cent_factor) end)
    |> Enum.reduce({:ok, []}, fn {ok_error, changeset}, acc -> accumulate_result(acc, {ok_error, changeset}) end)

    server
    |> Enum.filter(fn x -> not Enum.any?(db, fn y -> x.currency == y.currency end) end)
    |> Enum.map(fn x -> insert(x.currency, x.cent_factor) end)
    |> Enum.reduce(result, fn {ok_error, changeset}, acc -> accumulate_result(acc, {ok_error, changeset}) end)
    end
  end

  def accumulate_result({acc_result, acc_changeset}, {result, changeset}) do
    case result do
      :ok -> {acc_result, acc_changeset ++ changeset}
      _ -> {:error, acc_changeset ++ changeset}
    end
  end
end
