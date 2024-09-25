defmodule ExAccounting.Schema.Address do
  use Ecto.Schema


  # Trial of Generic Type: Generic type uses macro to define custom type
  schema "addresses" do
    field(:language, ExAccounting.Elem.GenericType.Language)
    field(:name, :string)
    field(:address, :string)
    field(:city, :string)
    field(:state, :string)
    field(:zip, ExAccounting.Elem.GenericType.Zip)
    field(:country, :string)
    timestamps()
    belongs_to(:individual_entity, ExAccounting.Schema.IndividualEntity)
  end


end
