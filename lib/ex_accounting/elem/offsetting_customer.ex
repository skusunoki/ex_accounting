defmodule ExAccounting.Elem.OffsettingCustomer do
  @moduledoc """
  _Offsetting Customer_ is the customer of the offsetting item of the docment.
  """

  use ExAccounting.Type
  entity(:customer, type: :string, length: 10, description: "Offsetting Customer")
end
