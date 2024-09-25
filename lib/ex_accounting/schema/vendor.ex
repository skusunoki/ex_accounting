defmodule ExAccounting.Schema.Vendor do
  @moduledoc false
  use Ecto.Schema

  alias ExAccounting.Elem.{
    Vendor
  }

  schema "vendors" do
    field(:vendor, Vendor)
    belongs_to(:individual_entity, ExAccounting.Schema.IndividualEntity)
  end
end
