defmodule ExAccounting.Elem.AccountingAreaCurrency do
  @moduledoc """
  _Accounting Area Currency_ is the currency of transaction.
  `cast/1` accepts Money. `equal?/2` compares the values of key `currency:`

  ## Examples

      iex> ExAccounting.EmbeddedSchema.Money.new(100, "USD")
      ...> |> ExAccounting.Elem.AccountingAreaCurrency.cast()
      {:ok, %ExAccounting.Elem.AccountingAreaCurrency{currency: :USD}}

      iex> with {:ok, curr1} <- ExAccounting.Elem.AccountingAreaCurrency.load("USD"),
      ...>      {:ok, curr2} <- ExAccounting.Elem.TransactionCurrency.load("USD") do
      ...> curr1 |> equal?(curr2)
      ...> end
      true

      iex> with {:ok, curr1} <- ExAccounting.Elem.AccountingAreaCurrency.load("JPY"),
      ...>      {:ok, curr2} <- ExAccounting.Elem.TransactionCurrency.load("USD") do
      ...> curr1 |> equal?(curr2)
      ...> end
      false

  """

  use ExAccounting.Type
  currency(:currency, description: "Accounting Area Currency")
end
