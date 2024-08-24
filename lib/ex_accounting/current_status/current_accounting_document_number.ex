defmodule ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber do
  @moduledoc """
  _Current Accounting Document Number_ is the state management of the document number issued for accounting document.
  Database table holds the last number issued for the accounting document; and the number is incremented by one for the next accounting document.
  """

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode
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
          current_document_number: integer | nil
        }

  @typedoc "Incremented or Newly created current document number. External form of the current document number."
  @type current_document_number :: %{
          number_range_code: AccountingDocumentNumberRangeCode.t(),
          current_document_number: integer
        }
  @typedoc "Function to read number range: _Accounting Document Number Range Code_ -> _Accounting Document Number Range_"
  @type read_config :: AccountingDocumentNumberRange.read()

  @typedoc "Function to read the current document number from the database."
  @type read :: (number_range_code -> t)

  schema "current_accounting_document_numbers" do
    field(:number_range_code, AccountingDocumentNumberRangeCode)
    field(:current_document_number, :integer)
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

  @spec make_changeset({:insert, t, current_document_number}) :: {:insert, Ecto.Changeset.t()}
  def make_changeset({:insert, _, after_updated}) do
    {:insert, changeset(%__MODULE__{}, after_updated)}
  end

  @spec make_changeset({:update, t, current_document_number}) :: {:update, Ecto.Changeset.t()}
  def make_changeset({:update, before_updated, after_updated}) do
    {:update, changeset(before_updated, after_updated)}
  end

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

  @spec increment(current_document_number) :: current_document_number
  def increment(current) do
    %{
      number_range_code: current.number_range_code,
      current_document_number: current.current_document_number + 1
    }
  end

  @spec read(number_range_code) :: t
  def read(
        %AccountingDocumentNumberRangeCode{
          accounting_document_number_range_code: code
        } = _number_range_code
      ) do
    from(p in __MODULE__, where: p.number_range_code == ^code)
    |> ExAccounting.Repo.one()
  end

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
