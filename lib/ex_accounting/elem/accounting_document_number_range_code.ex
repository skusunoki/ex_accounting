defmodule ExAccounting.Elem.AccountingDocumentNumberRangeCode do
  @moduledoc """
  Accounting Document Number Range Code controls document number issueed with in the defined ranges.
  Code should be 2 digits. Letters of code should be uppercase alphanumeric: A-Z or 0 - 9.
  """
  use ExAccounting.Type
  code(:accounting_document_number_range_code, type: :string, length: 2)
end
