defmodule ExAccounting.Configuration.Currency.Server do
  @moduledoc false

  use GenServer
  alias ExAccounting.Configuration.Currency.Impl
  alias ExAccounting.Configuration.Currency.DbGateway

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :init, name: __MODULE__)
  end

  def init(_) do
    {:ok, DbGateway.read()}
  end

  def handle_call(:read, _from, currencies) do
    {:reply, currencies, currencies}
  end

  @doc """
  add a new currency to the configuration.

  ## Examples

      iex> handle_call({:add, :usd}, 5000, [:jpy, :eur])
      {:reply, [:usd, :jpy, :eur], [:usd, :jpy, :eur]}
  """
  def handle_call({:add, currency}, _from, currencies) do
    with new_state <- Impl.add(currencies, currency) do
      {:reply, new_state, new_state}
    end
  end

  def handle_call({:cent_factor, currency}, _from, currencies) do
    {:reply, Impl.cent_factor(currency), currencies}
  end
end
