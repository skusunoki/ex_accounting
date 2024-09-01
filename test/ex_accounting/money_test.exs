defmodule ExAccounting.MoneyTest do
  use ExUnit.Case
  alias ExAccounting.Money
  alias ExAccounting.Money.Currency

  doctest Money, import: true
  doctest Currency, import: true
end
