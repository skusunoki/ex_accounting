defmodule Learning.DocumentItem do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:item, :integer)
    field(:transaction_amount, Learning.Money)
    field(:accounting_amount, Learning.Money)
  end

  def changeset(item, params \\ %{}) do
    item
    |> cast(params, [:item, :transaction_amount, :accounting_amount])
  end
end
