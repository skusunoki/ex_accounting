defmodule ExAccounting.Configuration.CurrencyConfigurationTest do
  use ExUnit.Case

  alias ExAccounting.Configuration.CurrencyConfiguration.Impl
  alias ExAccounting.Configuration.CurrencyConfiguration.Server

  doctest Impl, import: true
  doctest Server, import: true
end
