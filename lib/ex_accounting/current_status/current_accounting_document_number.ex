defmodule ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "current_accounting_document_numbers" do
    field(:number_range_code, :string)
    field(:current_document_number, :integer)
  end

  def changeset(current_accounting_document_number, params \\ %{}) do
    current_accounting_document_number
    |> cast(params, [:number_range_code, :current_document_number])
    |> unique_constraint(:number_range_code)
  end

  def make_changeset({:insert, _, changeset}) do
    {:insert, changeset(%__MODULE__{}, changeset)}
  end

  def make_changeset({:update, current, changeset}) do
    {:update, changeset(current, changeset)}
  end

  def create(number_range_code, read_number_range) do
    %{
      number_range_code: number_range_code,
      current_document_number:
        read_number_range.(number_range_code).accounting_document_number_from
    }
  end

  def increment(current) do
    %{
      number_range_code: current.number_range_code,
      current_document_number: current.current_document_number + 1
    }
  end

  def read(number_range_code) do
    from(p in __MODULE__, where: p.number_range_code == ^number_range_code)
    |> ExAccounting.Repo.one()
  end

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
