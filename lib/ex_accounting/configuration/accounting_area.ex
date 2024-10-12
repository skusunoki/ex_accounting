defmodule ExAccounting.Configuration.AccountingArea do
  # this is mock

  use Ecto.Schema
  import Ecto.Changeset

  @type t ::  %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer() | nil,
          accounting_area: ExAccounting.Elem.AccountingArea.t() | nil,
          accounting_area_currency: ExAccounting.Elem.AccountingAreaCurrency.t() | nil,
          accounting_units: [ExAccounting.Configuration.AccountingUnit.t()]
        }
  schema "accounting_areas" do
    field(:accounting_area, ExAccounting.Elem.AccountingArea)
    field(:accounting_area_currency, ExAccounting.Elem.AccountingAreaCurrency)
    has_many(:accounting_units, ExAccounting.Configuration.AccountingUnit)
  end

  def changeset(accounting_area, params) do
    accounting_area
    |> cast(params, [:accounting_area, :accounting_area_currency])
    |> validate_required([:accounting_area, :accounting_area_currency])
    |> cast_assoc(:accounting_units, with: &ExAccounting.Configuration.AccountingUnit.changeset/2)
  end

  def read() do
    with accounting_areas <-
           ["0001", "0002", "0003"]
           |> Enum.map(&accounting_area/1) do
      accounting_areas
    end
  end

  def accounting_area(term) do
    with {:ok, accounting_area} <- ExAccounting.Elem.AccountingArea.cast(term) do
      accounting_area
    else
      _ -> {:error, "Invalid accounting area"}
    end
  end

  def currency(_) do
    :USD
  end

  def description(_) do
    "Default"
  end
end
