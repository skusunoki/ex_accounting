defmodule ExAccounting.EmbeddedSchema.MoneyTest do
  use ExUnit.Case
  alias ExAccounting.EmbeddedSchema.Money
  alias ExAccounting.EmbeddedSchema.Money.Currency

  doctest Money, import: true
  doctest Currency, import: true
end
