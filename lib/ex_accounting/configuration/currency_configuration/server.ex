defmodule ExAccounting.Configuration.CurrencyConfiguration.Server do
  use GenServer
  alias ExAccounting.Configuration.CurrencyConfiguration.Impl
  alias ExAccounting.Configuration.CurrencyConfiguration.DbGateway

  def init(_dummy) do
    {:ok, DbGateway.read_from_db()}
  end

  def handle_call(:read, _from, currencies) do
    {:reply, currencies, currencies}
  end

  def handle_call({:add, currency}, _from, currencies) do
    {:reply, currencies, Impl.add(currencies, currency)}
  end
end
