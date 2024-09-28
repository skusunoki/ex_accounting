defmodule ExAccounting.Elem.FixedAsset do
  @moduledoc """
  Fixed Asset represents objects that accounting unit has rights to own not to sell but to use in business activity.
  """

  use ExAccounting.Type
  entity :fixed_asset, type: :string, length: 10
end
