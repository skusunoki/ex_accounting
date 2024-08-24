defmodule ExAccounting.Configuration.AccountingDocumentNumberRange do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @typedoc "_Accounting Document Number Range_"
  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer() | nil,
          number_range_code: String.t() | nil,
          accounting_document_number_from: integer() | nil,
          accounting_document_number_to: integer() | nil
        }

  @typedoc "_Accounting Document Number Range Code_"
  @type number_range_code :: ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode.t()

  @typedoc "Function to read number range: _Accounting Document Number Range Code_ -> _Accounting Document Number Range_"
  @type read :: (number_range_code -> t)

  schema "accounting_document_number_ranges" do
    field(:number_range_code, :string)
    field(:accounting_document_number_from, :integer)
    field(:accounting_document_number_to, :integer)
  end

  def changeset(accounting_document_number_range, params \\ %{}) do
    accounting_document_number_range
    |> cast(params, [
      :number_range_code,
      :accounting_document_number_from,
      :accounting_document_number_to
    ])
    |> unique_constraint([:number_range_code])
  end

  @spec create() :: t
  def create() do
    %__MODULE__{}
  end

  @spec read(number_range_code) :: t
  def read(number_range_code) do
    from(p in __MODULE__, where: p.number_range_code == ^number_range_code)
    |> ExAccounting.Repo.one()
  end

  @spec read() :: [t]
  def read() do
    ExAccounting.Configuration.AccountingDocumentNumberRange
    |> ExAccounting.Repo.all()
  end
end
