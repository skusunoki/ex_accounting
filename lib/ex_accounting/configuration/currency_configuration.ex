defmodule ExAccounting.Configuration.CurrencyConfiguration do
  @moduledoc """
  _Currency Configuration_ defines the currencies available in the system.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @typedoc "_Currency Configuration_"
  @type t :: %__MODULE__{
          currency: ExAccounting.Money.Currency.t()
        }

  schema "currency_configurations" do
    field(:currency, ExAccounting.Money.Currency, primary_key: true)
  end

  def changeset(currency_configuration, params \\ %{}) do
    currency_configuration
    |> cast(params, [:currency])
  end

  def read() do
    [
      :usd,
      :jpy,
      :eur
    ]

    # ExAccounting.Configuration.CurrencyConfiguration
    # |> ExAccounting.Repo.all()
  end
end
