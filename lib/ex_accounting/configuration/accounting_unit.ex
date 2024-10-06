defmodule ExAccounting.Configuration.AccountingUnit do
  # this is mock

  def accounting_area(_accounting_unit) do
    "0001"
  end

  def accounting_unit(_accounting_unit) do
    "1000"
  end

  def currency(_accounting_unit) do
    :USD
  end
end
