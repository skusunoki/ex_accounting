defmodule ExAccounting.Configuration do
  # mock
  def accounting_area(_accounting_unit) do
    %ExAccounting.Elem.AccountingArea{accounting_area: ~c"0001"}
  end

  def currency(_) do
    :USD
  end

  def read() do
    with accounting_areas <-
           ["0001", "0002", "0003"]
           |> Enum.map(&accounting_area/1) do
      accounting_areas
    end
  end

  def description(_) do
    "Default"
  end
end
