defmodule ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber do
  @moduledoc """
  _Current Accounting Document Number_ is the state management of the document number issued for accounting document.
  Database table holds the last number issued for the accounting document; and the number is incremented by one for the next accounting document.
  """

  use Ecto.Schema

  alias ExAccounting.Elem.AccountingDocumentNumber
  alias ExAccounting.Elem.AccountingDocumentNumberRangeCode
  alias ExAccounting.Configuration.AccountingDocumentNumberRange
  alias ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber.DbGateway

  @typedoc "_Accounting Document Number Range Code_"
  @type number_range_code :: AccountingDocumentNumberRangeCode.t()

  @typedoc "_Accounting Document Number Range_"
  @type number_range :: AccountingDocumentNumberRange.t()

  @typedoc "_Current Accounting Document Number_"
  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer() | nil,
          number_range_code: number_range_code | nil,
          current_document_number: AccountingDocumentNumber.t() | nil
        }

  @typedoc "Next document number which is incremented or newly created from the configuration of the accounting document number range."
  @type current_document_number :: %{
          number_range_code: AccountingDocumentNumberRangeCode.t(),
          current_document_number: AccountingDocumentNumber.t()
        }
  @typedoc "Function to read number range: _Accounting Document Number Range Code_ -> _Accounting Document Number Range_"
  @type read_config :: AccountingDocumentNumberRange.read()

  @typedoc "Function to read the current document number from the database."
  @type read :: (number_range_code -> t)

  @server ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber.Server

  schema "current_accounting_document_numbers" do
    field(:number_range_code, AccountingDocumentNumberRangeCode)
    field(:current_document_number, AccountingDocumentNumber)
  end

  @doc """
  Reads the current accounting document number from the database.
  """
  @spec read() :: [t]
  @spec read(number_range_code) :: t
  def read(
        %AccountingDocumentNumberRangeCode{} = number_range_code
      ) do
    GenServer.call(@server, {:read, number_range_code})
  end

  def read() do
    GenServer.call(@server, :read)
  end


  @doc """
  Issues the new document number for the given number range.
  Default _read_ function is used to read the current document number from the database;
  and the default _read_of_confg_ funtion is used to read the configuration of the accounting document number range.
  """
  @spec issue(number_range_code) :: any()
  def issue(number_range_code) do
    issue(number_range_code, &read/1, &ExAccounting.Configuration.AccountingDocumentNumberRange.read/1)
  end

  @doc """
  Issues the new document number for the given number range. If the number range is not found, it will initiate the number range.
  The first argument is the number range code.
  The second argument is the function to read the current document number from the database.
  The third argument is the function to read the configuration of the accounting document number range.
  """
  @spec issue(
          number_range_code,
          read(),
          read_config()
        ) :: any() | :error
  def issue(
        %AccountingDocumentNumberRangeCode{} = number_range_code,
        read,
        reader_of_config
      ) do
    with current = read.(number_range_code),
         %__MODULE__{} <- current do
      GenServer.call(@server, {:increment, current})
    else
      nil ->
        GenServer.call(@server, {:initiate, number_range_code, reader_of_config})
      _ ->
        :error
    end
  end

  def save() do
    with server = read() do
      DbGateway.save(server)
    end
  end
end
