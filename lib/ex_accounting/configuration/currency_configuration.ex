defmodule ExAccounting.Configuration.CurrencyConfiguration do
  @moduledoc """
  _Currency Configuration_ defines the currencies available in the system.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias ExAccounting.Configuration.CurrencyConfiguration.DbGateway

  @typedoc "_Currency Configuration_"

  @type t :: %__MODULE__{
          currency: ExAccounting.Money.Currency.t()
        }

  @server ExAccounting.Configuration.CurrencyConfiguration.Server

  @primary_key false
  embedded_schema do
    field(:currency, ExAccounting.Money.Currency)
  end

  @spec add(ExAccounting.Money.Currency.t()) :: :ok
  def add(currency) do
    GenServer.call(@server, {:add, currency})
  end

  @spec read() :: [atom()]
  def read() do
    GenServer.call(@server, :read)
  end

  def save() do
    with db_currencies = DbGateway.read(),
         currencies = read(),
         difference = currencies -- db_currencies,
         true <- length(difference) > 0 do
      for(c <- difference) do
        DbGateway.insert(c)
      end
    end
  end

  def changeset(%__MODULE__{} = struct, %{currency: _currency} = params) do
    struct
    |> cast(params, [:currency])
  end

  def cent_factor(currency) do
    GenServer.call(@server, {:cent_factor, currency})
    case currency do
      :USD -> 100
      :JPY -> 1
      :EUR -> 100
      _ -> 100
    end
  end
end
