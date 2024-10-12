defmodule ExAccounting.Configuration.AccountingArea.Server do
  use GenServer
  alias ExAccounting.Configuration.AccountingArea.DbGateway

  def init(_args) do
    {:ok, DbGateway.read()}
  end

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :init, name: __MODULE__)
  end

  def handle_call(:read, _from, accounting_area) do
    {:reply, accounting_area, accounting_area}
  end

  # def handle_call({:changeset, params}, _from, accounting_area) do
  #   with
  #   {:reply, }
  # end
end
