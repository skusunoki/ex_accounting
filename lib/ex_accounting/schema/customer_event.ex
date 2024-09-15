defmodule ExAccounting.Schema.CustomerEvent do
  use Ecto.Schema

  schema("customer_events") do
    field(:event_type, :string)
    belongs_to(:customer, ExAccounting.Schema.Customer)
    belongs_to(:address_before, ExAccounting.Schema.Address)
    belongs_to(:address_after, ExAccounting.Schema.Address)
    timestamps()
  end
end
