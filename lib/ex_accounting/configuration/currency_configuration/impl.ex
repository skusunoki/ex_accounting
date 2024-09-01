defmodule ExAccounting.Configuration.CurrencyConfiguration.Impl do
  def add(currencies, currency) do
    [currency | currencies]
  end

  def cent_factor(currency) do
    case currency do
      :USD -> 100
      :JPY -> 1
      :EUR -> 100
      _ -> 1
    end
  end
end
