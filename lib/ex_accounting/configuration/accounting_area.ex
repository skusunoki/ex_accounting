defmodule ExAccounting.Configuration.AccountingArea do
  # this is mock

  use Ecto.Schema

  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer() | nil,
          accounting_area: ExAccounting.Elem.AccountingArea.t() | nil,
          accounting_area_currency: ExAccounting.Elem.AccountingAreaCurrency.t() | nil,
          accounting_units: [ExAccounting.Configuration.AccountingArea.AccountingUnit.t()]
        }
  @server ExAccounting.Configuration.AccountingArea.Server
  schema "accounting_areas" do
    field(:accounting_area, ExAccounting.Elem.AccountingArea)
    field(:accounting_area_currency, ExAccounting.Elem.AccountingAreaCurrency)
    has_many(:accounting_units, ExAccounting.Configuration.AccountingArea.AccountingUnit)
  end

  defdelegate changeset(accounting_area, params),
    to: ExAccounting.Configuration.AccountingArea.Changeset

  def read() do
    GenServer.call(@server, :read)
  end

  def read(accounting_area) do
    GenServer.call(@server, {:read, accounting_area})
  end

  def add_accounting_area(%{
        accounting_area: accounting_area,
        accounting_area_currency: accounting_area_currency
      }) do
    GenServer.call(
      @server,
      {:add_accounting_area,
       %{accounting_area: accounting_area, accounting_area_currency: accounting_area_currency}}
    )
  end

  @spec add_accounting_unit(binary() | charlist() | ExAccounting.Elem.AccountingArea.t(), %{
          :accounting_unit => any(),
          :accounting_unit_currency => any(),
          optional(any()) => any()
        }) :: :error | {:error, any()}
  def add_accounting_unit(
        accounting_area,
        %{
          accounting_unit: _accounting_unit,
          accounting_unit_currency: _accounting_unit_currency
        } = params
      ) do
    GenServer.call(@server, {:add_accounting_unit, accounting_area, params})
  end

  def save() do
    GenServer.call(@server, :save)
  end
end
