defmodule ExAccounting.Configuration.AccountingArea do
  # this is mock

  def read() do
    with accounting_areas <-
           ["0001", "0002", "0003"]
           |> Enum.map(&accounting_area/1) do
      accounting_areas
    end
  end

  def accounting_area(term) do
    with {:ok, accounting_area} <- ExAccounting.Elem.AccountingArea.cast(term) do
      accounting_area
    else
      _ -> {:error, "Invalid accounting area"}
    end
  end

  def currency(_) do
    :USD
  end
end
