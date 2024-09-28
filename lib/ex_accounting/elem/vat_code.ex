defmodule ExAccounting.Elem.VatCode do
  @moduledoc """
  _VAT Code_ destinguishes the type of tax incurred.

  V1 - Standard Rate
  V2 - Reduced Rate
  V3 - Exempt

  """
  use ExAccounting.Type
  code(:vat_code, type: :string, length: 2)
end
