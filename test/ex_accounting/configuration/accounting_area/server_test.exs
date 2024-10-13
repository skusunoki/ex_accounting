defmodule ExAccounting.Configuration.AccountingArea.ServerTest do
  use ExUnit.Case
  alias ExAccounting.Configuration.AccountingArea.Server

  test "handle_call: add_accounting_area" do
    {:ok, accounting_areas} = Server.init(:dummy)

    added = %{accounting_area: "9901", accounting_area_currency: "GBP"}

    {:reply, _changeset, updated} =
      Server.handle_call({:add_accounting_area, added}, :dummy, accounting_areas)

    list = for x <- updated, do: Ecto.Changeset.apply_changes(x)

    assert Enum.any?(list, fn x ->
             x.accounting_area == %ExAccounting.Elem.AccountingArea{accounting_area: ~c"9901"}
           end)
  end

  test "handle_call: add_accounting_unit" do
    # setup
    {:ok, accounting_areas} = Server.init(:dummy)

    added = %{accounting_area: "9901", accounting_area_currency: "GBP"}

    {:reply, _changeset, updated} =
      Server.handle_call({:add_accounting_area, added}, :dummy, accounting_areas)

    # test
    added = %{accounting_unit: "9099", accounting_unit_currency: "USD"}

    {:reply, _changeset, updated} =
      Server.handle_call({:add_accounting_unit, "9901", added}, :dummy, updated)

    # assert

    added_accounting_area =
      updated
      |> Enum.map(fn x -> Ecto.Changeset.apply_changes(x) end)
      |> Enum.find(updated, fn x ->
        x.accounting_area == %ExAccounting.Elem.AccountingArea{accounting_area: ~c"9901"}
      end)

    assert Enum.any?(added_accounting_area.accounting_units, fn x ->
             x.accounting_unit == %ExAccounting.Elem.AccountingUnit{accounting_unit: ~c"9099"}
           end)
  end
end
