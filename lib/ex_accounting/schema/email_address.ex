defmodule ExAccounting.Schema.EmailAddress do
  use Ecto.Schema

  schema "email_addresses" do
    field(:email, :string)
    belongs_to(:destination, ExAccounting.Schema.Communication)
  end
end
