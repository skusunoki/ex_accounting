defmodule ExAccounting.Configuration.AccountingArea do
  # this is mock

  use Ecto.Schema

  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer() | nil,
          accounting_area: ExAccounting.Elem.AccountingArea.t() | nil,
          accounting_area_currency: ExAccounting.Elem.AccountingAreaCurrency.t() | nil,
          accounting_units: [ExAccounting.Configuration.AccountingArea.AccountingUnit.t()],
          accounting_document_number_ranges: [
            ExAccounting.Configuration.AccountingArea.AccountingDocumentNumberRange.t()
          ]
        }
  @server ExAccounting.Configuration.AccountingArea.Server
  schema "accounting_areas" do
    field(:accounting_area, ExAccounting.Elem.AccountingArea)
    field(:accounting_area_currency, ExAccounting.Elem.AccountingAreaCurrency)
    has_many(:accounting_units, ExAccounting.Configuration.AccountingArea.AccountingUnit)

    has_many(
      :accounting_document_number_ranges,
      ExAccounting.Configuration.AccountingArea.AccountingDocumentNumberRange
    )
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

  def add_accounting_document_number_range(
        accounting_area,
        %{
          number_range_code: _number_range_code,
          accounting_document_number_from: _accounting_document_number_from,
          accounting_document_number_to: _accounting_document_number_to
        } = params
      ) do
    GenServer.call(
      @server,
      {:add_accounting_document_number_range, accounting_area, params}
    )
  end

  def read_accounting_document_number_range(accounting_area, number_range_code) do
    GenServer.call(
      @server,
      {:read_accounting_document_number_range, accounting_area, number_range_code}
    )
  end

  def save() do
    GenServer.call(@server, :save)
  end
end
