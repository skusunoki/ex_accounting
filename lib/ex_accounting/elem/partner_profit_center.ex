defmodule ExAccounting.Elem.PartnerProfitCenter do
  @moduledoc """
  _Partner Profit Center_ is identifier of a partner profit center.
  """

  use ExAccounting.Type
  entity(:profit_center, type: :string, length: 10, description: "Partner Profit Center")
end
