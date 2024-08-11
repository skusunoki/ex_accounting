defmodule ExAccounting.Configuration.AccountingDocumentNumberRangeDetermination do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounting_document_number_range_determinations" do
    field(:accounting_unit, :string)
    field(:document_type, :string)
    field(:to_fiscal_year, :integer)
    field(:number_range_code, :string)
  end

  def changeset(accounting_document_number_range_determination, params \\ %{}) do
    accounting_document_number_range_determination
    |> cast(params, [:accounting_unit, :document_type, :to_fiscal_year, :number_range_code])
    |> unique_constraint([:accounting_unit, :document_type, :to_fiscal_year])
  end
end

defmodule ExAccounting.Configuration.AccountingDocumentNumberRange do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

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

  def create() do
    %__MODULE__{}
  end

  def read(number_range_code) do
    from(p in __MODULE__, where: p.number_range_code == ^number_range_code)
    |> ExAccounting.Repo.one()
  end
end
