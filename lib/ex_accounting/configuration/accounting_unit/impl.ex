defmodule ExAccounting.Configuration.AccountingUnit.Impl do
  @moduledoc false

  import Ecto.Changeset
  alias ExAccounting.Configuration.AccountingUnit
  alias ExAccounting.Configuration.AccountingUnit.Changeset

  def modify(
        accounting_units,
        accounting_unit,
        accounting_unit_currency,
        accounting_area
      ) do
    with {:ok, accounting_unit} <- ExAccounting.Elem.AccountingUnit.cast(accounting_unit) do
      case Enum.find(accounting_units, fn x ->
             ExAccounting.Elem.AccountingUnit.equal?(accounting_unit, x.accounting_unit)
           end) do
        nil ->
          with added =
                 %AccountingUnit{}
                 |> Changeset.changeset(%{
                   accounting_unit: accounting_unit,
                   accounting_unit_currency: accounting_unit_currency,
                   accounting_area: accounting_area
                 })
                 |> apply_changes() do
            accounting_units ++ [added]
          end

        code ->
          with result =
                 code
                 |> Changeset.changeset(%{
                   accounting_unit: accounting_unit,
                   accounting_unit_currency: accounting_unit_currency,
                   accounting_area: accounting_area
                 })
                 |> apply_changes() do
            (accounting_units -- [code]) ++ [result]
          end
      end
    end
  end

  @doc """
  Add a new accounting document number range.
  """
  @spec create() :: AccountingUnit.t()
  def create() do
    %AccountingUnit{}
  end

  @spec filter(
          accounting_units :: [
            ExAccounting.Configuration.AccountingUnit.t()
          ],
          accounting_unit :: String.t()
        ) :: [ExAccounting.Configuration.AccountingUnit.t()] | nil
  def filter(accounting_units, accounting_unit) do
    with {:ok, accounting_unit} <- ExAccounting.Elem.AccountingUnit.cast(accounting_unit) do
      Enum.filter(accounting_units, fn x ->
        ExAccounting.Elem.AccountingUnit.equal?(accounting_unit, x.accounting_unit)
      end)
    end
  end
end
