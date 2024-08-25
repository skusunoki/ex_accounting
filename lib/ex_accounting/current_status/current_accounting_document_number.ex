defmodule ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber do
  @moduledoc """
  _Current Accounting Document Number_ is the state management of the document number issued for accounting document.
  Database table holds the last number issued for the accounting document; and the number is incremented by one for the next accounting document.
  """

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias ExAccounting.Elem.AccountingDocumentNumber
  alias ExAccounting.Elem.AccountingDocumentNumberRangeCode
  alias ExAccounting.Configuration.AccountingDocumentNumberRange

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

  schema "current_accounting_document_numbers" do
    field(:number_range_code, AccountingDocumentNumberRangeCode)
    field(:current_document_number, AccountingDocumentNumber)
  end

  @doc """
  Makes the changeset for the current accounting document number.
  """
  @spec changeset(t(), %{}) :: Ecto.Changeset.t()
  @spec changeset(t(), current_document_number) :: Ecto.Changeset.t()
  def changeset(current_accounting_document_number, params \\ %{}) do
    current_accounting_document_number
    |> cast(params, [:number_range_code, :current_document_number])
    |> unique_constraint(:number_range_code)
  end

  @doc """
  Makes the changeset for the current accounting document number.
  The argument should be a tuple with the first element as the action to be taken to the database whether to insert or update.
  """
  @spec make_changeset({:insert, t, current_document_number}) :: {:insert, Ecto.Changeset.t()}
  @spec make_changeset({:update, t, current_document_number}) :: {:update, Ecto.Changeset.t()}
  def make_changeset({:insert, _, after_updated}) do
    {:insert, changeset(%__MODULE__{}, after_updated)}
  end

  def make_changeset({:update, before_updated, after_updated}) do
    {:update, changeset(before_updated, after_updated)}
  end

  @doc """
  Initiates the current accounting document number from the configuration of the accounting document number range.
  """
  @spec initiate(
          number_range_code,
          read_config
        ) :: current_document_number
  def initiate(number_range_code, read_number_range) do
    %{
      number_range_code: number_range_code,
      current_document_number:
        read_number_range.(number_range_code).accounting_document_number_from
    }
  end

  @doc """
  Increments the current document number by one.
  """
  @spec increment(current_document_number) :: current_document_number
  @spec increment(AccountingDocumentNumber.t()) :: AccountingDocumentNumber.t()
  def increment(
        %{number_range_code: _number_range_code, current_document_number: current_document_number} =
          current
      ) do
    with %AccountingDocumentNumber{} <- current_document_number do
      %{
        number_range_code: current.number_range_code,
        current_document_number: increment(current_document_number)
      }
    end
  end

  def increment(%AccountingDocumentNumber{accounting_document_number: number}) do
    %AccountingDocumentNumber{accounting_document_number: number + 1}
  end

  @doc """
  Reads the current accounting document number from the database.
  """
  @spec read(number_range_code) :: t
  def read(
        %AccountingDocumentNumberRangeCode{
          accounting_document_number_range_code: code
        } = _number_range_code
      ) do
    from(p in __MODULE__, where: p.number_range_code == ^code)
    |> ExAccounting.Repo.one()
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
        ) :: {:insert, t, any} | {:update, t, any}
  def issue(
        %AccountingDocumentNumberRangeCode{
          accounting_document_number_range_code: _code
        } = number_range_code,
        read,
        reader_of_config
      ) do
    with current = read.(number_range_code),
         %__MODULE__{} <- current do
      {:update, current, increment(Map.from_struct(current))}
    else
      nil ->
        {:insert, nil, initiate(number_range_code, reader_of_config)}

      _ ->
        :error
    end
  end
end
