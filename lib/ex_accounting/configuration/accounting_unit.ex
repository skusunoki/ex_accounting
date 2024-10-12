defmodule ExAccounting.Configuration.AccountingUnit do
  use Ecto.Schema
  alias ExAccounting.Configuration.AccountingUnit.DbGateway

  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer() | nil,
          accounting_unit: ExAccounting.Elem.AccountingUnit.t() | nil,
          accounting_unit_currency: ExAccounting.Elem.AccountingUnitCurrency.t() | nil,
        }

  @server ExAccounting.Configuration.AccountingUnit.Server

  schema "accounting_units" do
    field(:accounting_unit, ExAccounting.Elem.AccountingUnit)
    field(:accounting_unit_currency, ExAccounting.Elem.AccountingUnitCurrency)
    belongs_to(:accounting_area, ExAccounting.Configuration.AccountingArea)
  end

  def changeset(accounting_unit, params) do
    ExAccounting.Configuration.AccountingUnit.Changeset.changeset(accounting_unit, params)
  end

  def accounting_area(accounting_unit) do
    with [head | _] <- read(accounting_unit) do
      head.accounting_area
    end
  end

  def accounting_unit(accounting_unit) do
    with [head | _] <- read(accounting_unit) do
      head.accounting_unit
    end
  end

  def currency(accounting_unit) do
    with [head | _] <- read(accounting_unit) do
      head.accounting_unit_currency
    end
  end

  def read() do
    GenServer.call(@server, :read)
  end

  def read(accounting_unit) do
    GenServer.call(@server, {:read, accounting_unit})
  end

  def save() do
    with server <- read() do
      DbGateway.save(server)
    end
  end

  @spec modify(
          accounting_unit :: String.t(),
          accounting_unit_currency :: String.t(),
          accounting_area :: String.t()
        ) :: [t]
  @spec modify(%{
          accounting_unit: accounting_unit :: String.t(),
          accounting_unit_currency: accounting_unit_currency :: String.t(),
          accounting_area: accounting_area :: String.t()
        }) :: [t]
  def modify(
        accounting_unit,
        accounting_unit_currency,
        accounting_area
      ) do
    GenServer.call(
      @server,
      {:modify, accounting_unit, accounting_unit_currency, accounting_area}
    )
  end

  def modify(%{
        accounting_unit: accounting_unit,
        accounting_unit_currency: accounting_unit_currency,
        accounting_area: accounting_area
      }) do
    GenServer.call(
      @server,
      {:modify, accounting_unit, accounting_unit_currency, accounting_area}
    )
  end
end
