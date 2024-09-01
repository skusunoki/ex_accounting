defmodule ExAccounting.Configuration.AccountingDocumentNumberRange do
  @moduledoc """
  _Configuration_ module configures the ExAccounting system.

  ## Accounting Document Number Range

  The _accounting document number range_ is a range of numbers that are used to identify
  accounting documents; and has the first number and the last number of accounting document

  The _accounting document number range code_ is a unique identifier for the
  _accounting document number range_.

  The _accounting document number range_ can be created and changed by the following functions:
  - `create_accounting_document_number_range/3`
  - `change_accounting_document_number_range/3`

  """

  use Ecto.Schema
  alias ExAccounting.Configuration.AccountingDocumentNumberRange.DbGateway
  alias ExAccounting.Elem.AccountingDocumentNumberRangeCode
  alias ExAccounting.Elem.AccountingDocumentNumber

  @typedoc "_Accounting Document Number Range_"
  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer() | nil,
          number_range_code: AccountingDocumentNumberRangeCode.t() | nil,
          accounting_document_number_from: AccountingDocumentNumber.t() | nil,
          accounting_document_number_to: AccountingDocumentNumber.t() | nil
        }

  @typedoc "_Accounting Document Number Range Code_"
  @type number_range_code :: ExAccounting.Elem.AccountingDocumentNumberRangeCode.t()

  @typedoc "Function to read number range: _Accounting Document Number Range Code_ -> _Accounting Document Number Range_"
  @type read :: (number_range_code -> t)

  @typedoc "_Accounting Document Number Range Code_"
  @type accounting_document_number_range_code :: AccountingDocumentNumberRangeCode.t()

  @server ExAccounting.Configuration.AccountingDocumentNumberRange.Server

  schema "accounting_document_number_ranges" do
    field(:number_range_code, ExAccounting.Elem.AccountingDocumentNumberRangeCode)
    field(:accounting_document_number_from, ExAccounting.Elem.AccountingDocumentNumber)
    field(:accounting_document_number_to, ExAccounting.Elem.AccountingDocumentNumber)
  end

  @doc """
  Reads the accounting document number ranges.

  ## Examples

      iex> modify("TS", 100, 199)
      iex> read("TS")
      [
        %ExAccounting.Configuration.AccountingDocumentNumberRange{
          __meta__: #Ecto.Schema.Metadata<:loaded, "accounting_document_number_ranges">,
          id: nil,
          number_range_code: "TS",
          accounting_document_number_from: 100,
          accounting_document_number_to: 199
        }
      ]
  """
  @spec read() :: [t]
  @spec read(number_range_code) :: [t]
  def read() do
    GenServer.call(@server, :read)
  end

  def read(number_range_code) do
    GenServer.call(@server, {:read, number_range_code})
  end

  @spec modify(
          number_range_code :: String.t(),
          accounting_document_number_from :: integer(),
          accounting_document_number_to :: integer()
        ) :: [t]
  def modify(
        number_range_code,
        accounting_document_number_from,
        accounting_document_number_to
      ) do
    GenServer.call(
      @server,
      {:modify, number_range_code, accounting_document_number_from, accounting_document_number_to}
    )
  end

  @doc """
  Saves the accouting document number ranges to the database.
  """
  @spec save() :: {:ok, [Ecto.Changeset.t()]} | {:error, [Ecto.Changeset.t()]}
  def save() do
    with server = read() do
      DbGateway.save(server)
    end
  end
end
