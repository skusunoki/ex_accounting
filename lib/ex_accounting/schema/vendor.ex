defmodule ExAccounting.Schema.Vendor do
  @moduledoc false
  use Ecto.Schema

  alias ExAccounting.Elem.{
    Vendor,
  }

  schema "vendors" do
    field(:vendor, Vendor)
    field(:vendor_address, :integer)
    field(:communication_language, :string)
  end
end
