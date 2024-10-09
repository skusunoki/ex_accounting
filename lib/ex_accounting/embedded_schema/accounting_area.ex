defmodule ExAccounting.EmbeddedSchema.AccountingArea do
  @moduledoc """
  _Accounting Area_
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias ExAccounting.Configuration.AccountingArea

  @typedoc """
  _Accounting Area_
  """
  @type t :: %__MODULE__{
          accounting_area: ExAccounting.Elem.AccountingArea.t(),
          accounting_area_currency: ExAccounting.Elem.AccountingAreaCurrency.t()
        }
  embedded_schema do
    field(:accounting_area, ExAccounting.Elem.AccountingArea)
    field(:accounting_area_description, ExAccounting.Elem.AccountingAreaDescription)
    field(:accounting_area_currency, ExAccounting.Elem.AccountingAreaCurrency)
  end

  @spec changeset(t, map) :: Ecto.Changeset.t
  def changeset(accounting_area, params) do
    param_comp =
      params
      |> determine_accounting_area_currency()
      |> determine_accounting_area_description()

    accounting_area
    |> cast(param_comp, [:accounting_area, :accounting_area_description, :accounting_area_currency])
    |> validate_required([:accounting_area, :accounting_area_currency])
    |> validate_inclusion(:accounting_area, AccountingArea.read())
  end

  @spec determine_accounting_area_currency(map) :: map
  defp determine_accounting_area_currency(%{accounting_area: key, accounting_area_currency: curr} = params)
       when not is_nil(key) and not is_nil(curr) do
    params
  end

  defp determine_accounting_area_currency(%{accounting_area: key} = params)
      when not is_nil(key)  do
    params
    |> Map.put(:accounting_area_currency, AccountingArea.currency(params.accounting_area))
  end

  @spec determine_accounting_area_description(map) :: map
  defp determine_accounting_area_description(%{accounting_area_description: key} = params)
       when not is_nil(key) do
    params
  end

  defp determine_accounting_area_description(params) when is_map(params) do
    params
    |> Map.put(:accounting_area_description, AccountingArea.description(params.accounting_area))
  end
end
