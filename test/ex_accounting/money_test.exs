defmodule ExAccounting.MoneyTest do
  use ExUnit.Case
  alias ExAccounting.Money
  alias ExAccounting.Money.Currency

  doctest ExAccounting.Money, import: true
  doctest ExAccounting.Money.Currency, import: true
end
