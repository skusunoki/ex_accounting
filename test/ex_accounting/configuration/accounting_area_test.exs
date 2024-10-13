defmodule ExAccounting.Configuration.AccountingAreaTest do
  use ExUnit.Case

  test "reads non nil accounting area value" do
    actual =
      ExAccounting.Configuration.AccountingArea.read()
      |> Enum.map(fn x -> Map.get(x, :accounting_area) end)

    assert actual |> Enum.all?(fn x -> x != nil end)
  end

  test "added new accounting area can be read" do
    new = %{
      accounting_area: "0002",
      accounting_area_currency: "USD",
      accounting_units: [
        %{accounting_unit: "2000", accounting_unit_currency: "USD"},
        %{accounting_unit: "2001", accounting_unit_currency: "USD"},
        %{accounting_unit: "2002", accounting_unit_currency: "USD"}
      ]
    }

    changeset =
      %ExAccounting.Configuration.AccountingArea{}
      |> ExAccounting.Configuration.AccountingArea.changeset(new)

    result = changeset |> Ecto.Changeset.apply_action(:insert)
    errors = changeset |> Ecto.Changeset.traverse_errors(fn {msg, opts} -> {msg, opts} end)

    assert errors == %{}
    assert result |> elem(0) == :ok

    assert result |> elem(1) |> Map.get(:accounting_area) == %ExAccounting.Elem.AccountingArea{
             accounting_area: ~c"0002"
           }

    assert result |> elem(1) |> Map.get(:accounting_area_currency) ==
             %ExAccounting.Elem.AccountingAreaCurrency{currency: :USD}

    assert result |> elem(1) |> Map.get(:accounting_units) == [
             %ExAccounting.Configuration.AccountingArea.AccountingUnit{
               accounting_unit: %ExAccounting.Elem.AccountingUnit{accounting_unit: ~c"2000"},
               accounting_unit_currency: %ExAccounting.Elem.AccountingUnitCurrency{currency: :USD}
             },
             %ExAccounting.Configuration.AccountingArea.AccountingUnit{
               accounting_unit: %ExAccounting.Elem.AccountingUnit{accounting_unit: ~c"2001"},
               accounting_unit_currency: %ExAccounting.Elem.AccountingUnitCurrency{currency: :USD}
             },
             %ExAccounting.Configuration.AccountingArea.AccountingUnit{
               accounting_unit: %ExAccounting.Elem.AccountingUnit{accounting_unit: ~c"2002"},
               accounting_unit_currency: %ExAccounting.Elem.AccountingUnitCurrency{currency: :USD}
             }
           ]
  end

  test "add_accounting_unit to existing accounting area" do
    accounting_area = %{
      accounting_area: "9901",
      accounting_area_currency: "GBP"
    }

    accounting_unit = %{
      accounting_unit: "9000",
      accounting_unit_currency: "EUR"
    }

    ExAccounting.Configuration.AccountingArea.add_accounting_area(accounting_area)
    ExAccounting.Configuration.AccountingArea.add_accounting_unit("9901", accounting_unit)

    assert ExAccounting.Configuration.AccountingArea.read()
           |> Enum.find(fn x ->
             Map.get(x, :accounting_area) == %ExAccounting.Elem.AccountingArea{
               accounting_area: ~c"9901"
             }
           end)
           |> Map.get(:accounting_units) ==
             [
               %ExAccounting.Configuration.AccountingArea.AccountingUnit{
                 accounting_unit: %ExAccounting.Elem.AccountingUnit{accounting_unit: ~c"9000"},
                 accounting_unit_currency: %ExAccounting.Elem.AccountingUnitCurrency{
                   currency: :EUR
                 },
                 accounting_document_number_range_determinations: []}
             ]
  end

  test "accounting_area_from_accounting_unit" do
    accounting_areas = [%{
      accounting_area: "9901",
      accounting_area_currency: "GBP",
      accounting_units: [
        %{accounting_unit: "9000", accounting_unit_currency: "EUR"},
        %{accounting_unit: "9001", accounting_unit_currency: "EUR"},
        %{accounting_unit: "9002", accounting_unit_currency: "EUR"}
      ]
    },
    %{
      accounting_area: "9902",
      accounting_area_currency: "EUR",
      accounting_units: [
        %{accounting_unit: "9020", accounting_unit_currency: "GBP"},
        %{accounting_unit: "9021", accounting_unit_currency: "GBP"},
        %{accounting_unit: "9022", accounting_unit_currency: "GBP"}
      ]

    }]

    # struct = %ExAccounting.Configuration.AccountingArea{}

    _changeset =
    accounting_areas
    |> tap(&Enum.map(&1, fn x -> ExAccounting.Configuration.AccountingArea.add_accounting_area(x) end))

    ExAccounting.Configuration.AccountingArea.add_accounting_unit("9901", %{accounting_unit: "9000", accounting_unit_currency: "EUR"})
    ExAccounting.Configuration.AccountingArea.add_accounting_unit("9901", %{accounting_unit: "9001", accounting_unit_currency: "EUR"})
    ExAccounting.Configuration.AccountingArea.add_accounting_unit("9901", %{accounting_unit: "9002", accounting_unit_currency: "EUR"})
    ExAccounting.Configuration.AccountingArea.add_accounting_unit("9902", %{accounting_unit: "9020", accounting_unit_currency: "EUR"})
    ExAccounting.Configuration.AccountingArea.add_accounting_unit("9902", %{accounting_unit: "9021", accounting_unit_currency: "EUR"})
    ExAccounting.Configuration.AccountingArea.add_accounting_unit("9902", %{accounting_unit: "9022", accounting_unit_currency: "EUR"})
      assert ExAccounting.Configuration.AccountingArea.accounting_area_from_accounting_unit("9000") == "9901"
      assert ExAccounting.Configuration.AccountingArea.accounting_area_from_accounting_unit("9020") == "9902"

  end
end
