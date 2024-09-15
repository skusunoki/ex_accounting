defmodule ExAccounting.Schema.Customer do
  @moduledoc false
  use Ecto.Schema

  alias ExAccounting.Elem.{
    Customer,
  }

  schema "customers" do
    field(:customer, Customer)
    belongs_to(:individual_entity, ExAccounting.Schema.IndividualEntity)
  end
end
