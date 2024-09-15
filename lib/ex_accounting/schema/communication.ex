defmodule ExAccounting.Schema.Communication do
  use Ecto.Schema

  schema "communications" do
    field(:language, :string)
    field(:communication_type, :string)
    has_one(:email_address, ExAccounting.Schema.EmailAddress)
    has_one(:phone_number, ExAccounting.Schema.PhoneNumber)
    belongs_to(:individual_entity, ExAccounting.Schema.IndividualEntity)
  end
end
