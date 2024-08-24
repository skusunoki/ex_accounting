defmodule ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode
  alias ExAccounting.Configuration.AccountingDocumentNumberRange

  @type number_range_code :: AccountingDocumentNumberRangeCode.t()
  @type number_range :: AccountingDocumentNumberRange.t()
  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer() | nil,
          number_range_code: number_range_code | nil,
          current_document_number: integer | nil
        }

  @type current_document_number :: %{
          number_range_code: AccountingDocumentNumberRangeCode.t(),
          current_document_number: integer
        }
  @type read_config :: AccountingDocumentNumberRange.read()
  @type read :: (number_range_code -> t)
  schema "current_accounting_document_numbers" do
    field(:number_range_code, AccountingDocumentNumberRangeCode)
    field(:current_document_number, :integer)
  end

  @doc """
  Makes the changeset for the current accounting document number.

  ## Examples

        iex> CurrentAccountingDocumentNumber.changeset(%CurrentAccountingDocumentNumber{number_range_code: "01", current_document_number: 1},
        ...> %{number_range_code: "01", current_document_number: 2})
        #Ecto.Changeset<action: nil, changes: %{number_range_code: %ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode{accounting_document_number_range_code: \"01\"}, current_document_number: 2}, errors: [], data: #ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber<>, valid?: true>
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
