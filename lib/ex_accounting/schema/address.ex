defmodule ExAccounting.Schema.Address do
  use Ecto.Schema

  schema "addresses" do
    field(:language, :string)
    field(:name, :string)
    field(:address, :string)
    field(:city, :string)
    field(:state, :string)
    field(:zip, :string)
    field(:country, :string)
    timestamps()
    belongs_to(:individual_entity, ExAccounting.Schema.IndividualEntity)
  end
end
