defmodule ExAccounting.Configuration.CurrencyConfiguration.Impl do
  def add(currencies, currency) do
    [currency | currencies]
  end
end
