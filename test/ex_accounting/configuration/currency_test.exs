defmodule ExAccounting.Configuration.CurrencyTest do
  use ExUnit.Case

  alias ExAccounting.Configuration.Currency.Impl
  alias ExAccounting.Configuration.Currency.Server

  doctest Impl, import: true
  doctest Server, import: true
end
