defmodule ExAccounting.Elem.ReversedDocumentAccountingUnit do
  @moduledoc """
  _Reversed Document Accounting Unit_ is the Accounting Unit of the document to be reversed.
  """
  use ExAccounting.Type
  code(:accounting_unit, type: :string, length: 4)
end
