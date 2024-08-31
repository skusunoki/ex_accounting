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
  alias ExAccounting.Configuration.AccountingDocumentNumberRange.Changeset
  alias ExAccounting.Configuration.AccountingDocumentNumberRange
  alias ExAccounting.Configuration.AccountingDocumentNumberRange.DbGateway
  alias ExAccounting.Configuration.AccountingDocumentNumberRange.Changeset
  alias ExAccounting.Elem.AccountingDocumentNumberRangeCode

  @typedoc "_Accounting Document Number Range_"
  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer() | nil,
          number_range_code: ExAccounting.Elem.AccountingDocumentNumberRangeCode.t() | nil,
          accounting_document_number_from: ExAccounting.Elem.AccountingDocumentNumber.t() | nil,
          accounting_document_number_to: ExAccounting.Elem.AccountingDocumentNumber.t() | nil
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

  def start_link(_args) do
    GenServer.start_link(@server, :init, name: @server)
  end

  @spec read(number_range_code) :: t
  def read(number_range_code) do
    GenServer.call(@server, {:read, number_range_code})
  end

  def read() do
    GenServer.call(@server, :read)
  end

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
  Creates the accounting document number range from the given number range code, the first number of accounting document, and the last number of accounting document.
  """

  def save() do
    with db = DbGateway.read(),
         server = read() do
      server
      |> Enum.filter(fn x ->
        Enum.any?(db, fn y -> x.number_range_code == y.number_range_code end)
      end)
      |> Enum.map(fn x -> update(x) end)

      server
      |> Enum.filter(fn x ->
        not Enum.any?(db, fn y -> x.number_range_code == y.number_range_code end)
      end)
      |> Enum.map(fn x -> insert(x) end)
    end
  end

  def insert(accounting_document_number_range) do
    DbGateway.create()
    |> Changeset.changeset(%{
      number_range_code: accounting_document_number_range.number_range_code,
      accounting_document_number_from:
        accounting_document_number_range.accounting_document_number_from,
      accounting_document_number_to:
        accounting_document_number_range.accounting_document_number_to
    })
    |> ExAccounting.Repo.insert()
  end

  def update(accounting_document_number_range) do
    DbGateway.read(accounting_document_number_range.number_range_code)
    |> Changeset.changeset(%{
      number_range_code: accounting_document_number_range.number_range_code,
      accounting_document_number_from:
        accounting_document_number_range.accounting_document_number_from,
      accounting_document_number_to:
        accounting_document_number_range.accounting_document_number_to
    })
    |> ExAccounting.Repo.update()
  end

  @spec create_accounting_document_number_range(
          number_range_code ::
            accounting_document_number_range_code,
          accounting_document_number_from :: integer,
          accounting_document_number_to :: integer
        ) :: {:ok, AccountingDocumentNumberRange.t()} | {:error, Ecto.Changeset.t()}
  def create_accounting_document_number_range(
        number_range_code,
        accounting_document_number_from,
        accounting_document_number_to
      ) do
    DbGateway.create()
    |> Changeset.changeset(%{
      number_range_code: number_range_code,
      accounting_document_number_from: accounting_document_number_from,
      accounting_document_number_to: accounting_document_number_to
    })
    |> ExAccounting.Repo.insert()
  end

  @doc """
  Changes the accounting document number range from the given number range code, the first number of accounting document, and the last number of accounting document.
  """
  @spec change_accounting_document_number_range(
          number_range_code ::
            accounting_document_number_range_code,
          accounting_document_number_from :: integer,
          accounting_document_number_to :: integer
        ) :: {:ok, AccountingDocumentNumberRange.t()} | {:error, Ecto.Changeset.t()}
  def change_accounting_document_number_range(
        number_range_code,
        accounting_document_number_from,
        accounting_document_number_to
      ) do
    read(number_range_code)
    |> Changeset.changeset(%{
      number_range_code: number_range_code,
      accounting_document_number_from: accounting_document_number_from,
      accounting_document_number_to: accounting_document_number_to
    })
    |> ExAccounting.Repo.update()
  end
end
