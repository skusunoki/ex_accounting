defmodule ExAccounting.EmbeddedSchema.AccountingUnit do
  @moduledoc """
  _Accounting Unit_ is a unit of accounting.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          accounting_unit: ExAccounting.Elem.AccountingUnit.t(),
          accounting_unit_currency: ExAccounting.Elem.AccountingUnitCurrency.t(),
          accounting_area: ExAccounting.EmbeddedSchema.AccountingArea.t()
        }
  embedded_schema do
    field(:accounting_unit, ExAccounting.Elem.AccountingUnit)
    field(:accounting_unit_currency, ExAccounting.Elem.AccountingUnitCurrency)
    embeds_one(:accounting_area, ExAccounting.EmbeddedSchema.AccountingArea)
  end

  def changeset(accounting_unit, params) do
    params_comp =
      params
      |> determine_accounting_unit_currency()
      |> determine_accounting_area()

    accounting_unit
    |> cast(params_comp, [:accounting_unit, :accounting_unit_currency])
    |> validate_required([:accounting_unit, :accounting_unit_currency])
    |> cast_embed(:accounting_area,
      with: &ExAccounting.EmbeddedSchema.AccountingArea.changeset/2
    )
  end

  defp determine_accounting_unit_currency(%{accounting_unit_currency: _key} = params) do
    params
  end

  defp determine_accounting_unit_currency(params) when is_map(params) do
    params
    |> Map.put(
      :accounting_unit_currency,
      ExAccounting.Configuration.AccountingUnit.currency(params.accounting_unit)
    )
  end

  defp determine_accounting_area(%{accounting_area: key} = params) when not is_nil(key) do
    params
  end

  defp determine_accounting_area(params) when is_map(params) do
    params
    |> Map.put(:accounting_area, %{
      accounting_area:
        ExAccounting.Configuration.accounting_area(params.accounting_unit)
    })
  end
end
