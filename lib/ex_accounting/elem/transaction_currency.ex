defmodule ExAccounting.Elem.TransactionCurrency do
  @moduledoc """
  _Transaction Currency_ is the currency of transaction.

  ## Example

      iex> ExAccounting.EmbeddedSchema.Money.new(100, "USD") |> ExAccounting.Elem.TransactionCurrency.cast()
      {:ok, %ExAccounting.Elem.TransactionCurrency{currency: :USD}}

      iex> load("USD")
      {:ok, %ExAccounting.Elem.TransactionCurrency{currency: :USD}}

      iex> with {:ok, curr} <- load("USD"),
      ...>      {:ok, curr} <- cast(curr),
      ...>      {:ok, curr} <- dump(curr) do
      ...>  curr
      ...> end
      "USD"
  """
  use ExAccounting.Type
  currency(:currency, description: "Transaction Currency")
end
