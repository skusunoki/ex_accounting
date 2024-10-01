defmodule ExAccounting.Elem.AccountingAreaCurrency do
  @moduledoc """
  _Accounting Area Currency_ is the currency of transaction.

  ## Examples

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
