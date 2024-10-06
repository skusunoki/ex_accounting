defmodule ExAccounting.EmbeddedSchema.AccountingArea do
  @moduledoc """
  _Accounting Area_
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias ExAccounting.Configuration.AccountingArea

  embedded_schema do
    field(:accounting_area, ExAccounting.Elem.AccountingArea)
    field(:accounting_area_currency, ExAccounting.Elem.AccountingAreaCurrency)
  end

  def changeset(accounting_area, params) do
    param_comp = params
    |> determine_accounting_area_currency()

    accounting_area
    |> cast(param_comp, [:accounting_area, :accounting_area_currency])
    |> validate_required([:accounting_area, :accounting_area_currency])
    |> validate_inclusion(:accounting_area, AccountingArea.read())
  end

  defp determine_accounting_area_currency(%{accounting_area_currency: key} = params) when not is_nil(key) do
    params
  end

  defp determine_accounting_area_currency(params) when is_map(params) do
    params
    |> Map.put(:accounting_area_currency, AccountingArea.currency(params.accounting_area))
  end
end
