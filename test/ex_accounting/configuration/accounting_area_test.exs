defmodule ExAccounting.Configuration.AccountingAreaTest do
  use ExUnit.Case

  test "reads non nil accounting area value" do
    actual =
      ExAccounting.Configuration.AccountingArea.read()
      |> Enum.map(fn x -> Map.get(x, :accounting_area) end)

    assert actual |> Enum.all?(fn x -> x != nil end)
  end

  test "added new accounting area can be read" do
    new = %{accounting_area: "0002", accounting_area_currency: "USD", accounting_units: [
      %{accounting_unit: "2000", accounting_unit_currency: "USD"},
      %{accounting_unit: "2001", accounting_unit_currency: "USD"},
      %{accounting_unit: "2002", accounting_unit_currency: "USD"}
    ]}

    changeset =
    %ExAccounting.Configuration.AccountingArea{}
    |> ExAccounting.Configuration.AccountingArea.changeset(new)

    result = changeset |> Ecto.Changeset.apply_action(:insert)
    errors = changeset |> Ecto.Changeset.traverse_errors(fn {msg, opts} -> {msg, opts} end)

    assert errors == %{}
    assert result |> elem(0) == :ok
    assert result |> elem(1) |> Map.get(:accounting_area) == %ExAccounting.Elem.AccountingArea{accounting_area: ~c"0002"}
    assert result |> elem(1) |> Map.get(:accounting_area_currency) == %ExAccounting.Elem.AccountingAreaCurrency{currency: :USD}
    assert result |> elem(1) |> Map.get(:accounting_units) == [
      %ExAccounting.Configuration.AccountingUnit{accounting_unit: %ExAccounting.Elem.AccountingUnit{accounting_unit: ~c"2000"}, accounting_unit_currency: %ExAccounting.Elem.AccountingUnitCurrency{currency: :USD}},
      %ExAccounting.Configuration.AccountingUnit{accounting_unit: %ExAccounting.Elem.AccountingUnit{accounting_unit: ~c"2001"}, accounting_unit_currency: %ExAccounting.Elem.AccountingUnitCurrency{currency: :USD}},
      %ExAccounting.Configuration.AccountingUnit{accounting_unit: %ExAccounting.Elem.AccountingUnit{accounting_unit: ~c"2002"}, accounting_unit_currency: %ExAccounting.Elem.AccountingUnitCurrency{currency: :USD}}
    ]


  end

end
