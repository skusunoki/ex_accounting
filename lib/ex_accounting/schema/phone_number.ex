defmodule ExAccounting.Schema.PhoneNumber do
  use Ecto.Schema

  schema "phone_numbers" do
    field(:phone_number, :string)
    belongs_to(:destination, ExAccounting.Schema.Communication)
  end
end
