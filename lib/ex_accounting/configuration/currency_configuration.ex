defmodule ExAccounting.Configuration.CurrencyConfiguration do
  @moduledoc """
  _Currency Configuration_ defines the currencies available in the system.
  """
  use Ecto.Schema
  alias ExAccounting.Configuration.CurrencyConfiguration.DbGateway

  @server ExAccounting.Configuration.CurrencyConfiguration.Server

  @typedoc "_Currency Configuration_"
  @type t :: %__MODULE__{
          currency: ExAccounting.Money.Currency.t()
        }

  schema "currency_configurations" do
    field(:currency, ExAccounting.Money.Currency, primary_key: true)
  end

  def start_link(_args) do
    GenServer.start_link(@server, :init, name: @server)
  end

  def add(currency) do
    GenServer.call(@server, {:add, currency})
  end

  def read() do
    GenServer.call(@server, :read)
  end

  def save() do
    with db_currencies = DbGateway.read_from_db(),
         currencies = read(),
         difference = currencies -- db_currencies,
         true <- length(difference) > 0 do
      for(c <- difference) do
        DbGateway.insert(c)
      end
    end
  end
end
