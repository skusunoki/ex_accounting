defmodule ExAccounting.Schema.IndividualEntity do
  use Ecto.Schema

  schema "individual_entities" do
    has_one(:customer, ExAccounting.Schema.Customer)
    has_one(:vendor, ExAccounting.Schema.Vendor)
    has_many(:address, ExAccounting.Schema.Address)
    has_many(:communication, ExAccounting.Schema.Communication)
  end
end
