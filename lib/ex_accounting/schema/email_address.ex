defmodule ExAccounting.Schema.EmailAddress do
  use Ecto.Schema

  schema "email_addresses" do
    field(:email, :string)
    belongs_to(:communication, ExAccounting.Schema.Communication)
  end
end
