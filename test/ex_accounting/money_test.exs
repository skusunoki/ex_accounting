defmodule ExAccounting.EmbeddedSchema.MoneyTest do
  use ExUnit.Case
  alias ExAccounting.EmbeddedSchema.Money
  alias ExAccounting.Elem.Currency

  doctest Money, import: true
  doctest Currency, import: true
end
