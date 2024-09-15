defmodule ExAccounting.Schema.PhoneNumber do
  use Ecto.Schema

  schema "phone_numbers" do
    field(:phone_number, :string)
    belongs_to(:communication, ExAccounting.Schema.Communication)
  end
end
