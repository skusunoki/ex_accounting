defmodule ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @type number_range_code :: ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode.t()
  @type number_range :: ExAccounting.Configuration.AccountingDocumentNumberRange.t()
  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer() | nil,
          number_range_code: number_range_code | nil,
          current_document_number: integer | nil
        }

  @type current_document_number :: %{
          number_range_code:
            ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode.t(),
          current_document_number: integer
        }

  schema "current_accounting_document_numbers" do
    field(:number_range_code, :string)
    field(:current_document_number, :integer)
  end

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

  @spec create(
          number_range_code,
          (number_range_code -> t)
        ) :: current_document_number
  def create(number_range_code, read_number_range) do
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
  def read(number_range_code) do
    from(p in __MODULE__, where: p.number_range_code == ^number_range_code)
    |> ExAccounting.Repo.one()
  end

  @spec issue(
          number_range_code,
          (number_range_code -> t),
          (number_range_code ->
             number_range)
        ) :: {:insert, t, any} | {:update, t, any}
  def issue(number_range_code, read_current, read_number_range) do
    case read_current.(number_range_code) do
      nil ->
        {:insert, read_current.(number_range_code), create(number_range_code, read_number_range)}

      %__MODULE__{
        number_range_code: ^number_range_code,
        current_document_number: current_document_number
      } ->
        {:update, read_current.(number_range_code),
         increment(%{
           number_range_code: number_range_code,
           current_document_number: current_document_number
         })}
    end
  end
end
