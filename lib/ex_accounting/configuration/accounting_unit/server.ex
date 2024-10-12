defmodule ExAccounting.Configuration.AccountingUnit.Server do
  use GenServer
  alias ExAccounting.Configuration.AccountingUnit.DbGateway
  alias ExAccounting.Configuration.AccountingUnit.Impl

  def init(_args) do
    {:ok, DbGateway.read()}
  end

  def handle_call(:read, _from, accounting_unit_attr) do
    {:reply, accounting_unit_attr, accounting_unit_attr}
  end

  def handle_call({:read, accounting_unit}, _from, accounting_unit_attr) do
    {:reply, Impl.filter(accounting_unit_attr, accounting_unit), accounting_unit_attr}
  end

  def handle_call(
        {:modify, accounting_unit, accounting_unit_currency, accounting_area},
        _from,
        accounting_unit_attr
      ) do
    {:reply, accounting_unit_attr,
     Impl.modify(
       accounting_unit_attr,
       accounting_unit,
       accounting_unit_currency,
       accounting_area
     )}
  end

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :init, name: __MODULE__)
  end
end
