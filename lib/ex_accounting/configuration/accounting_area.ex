defmodule ExAccounting.Configuration.AccountingArea do
  # this is mock

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer() | nil,
          accounting_area: ExAccounting.Elem.AccountingArea.t() | nil,
          accounting_area_currency: ExAccounting.Elem.AccountingAreaCurrency.t() | nil,
          accounting_units: [ExAccounting.Configuration.AccountingUnit.t()]
        }
  @server ExAccounting.Configuration.AccountingArea.Server
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
    GenServer.call(@server, :read)
  end
end
