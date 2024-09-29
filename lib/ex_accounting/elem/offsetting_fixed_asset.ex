defmodule ExAccounting.Elem.OffsettingFixedAsset do
  @moduledoc """
  _Offsetting Fixed Asset_ is the fixed asset of the offsetting item of the docment
  """

  use ExAccounting.Type
  entity(:fixed_asset, type: :string, length: 10, description: "Offsetting Fixed Asset")
end
