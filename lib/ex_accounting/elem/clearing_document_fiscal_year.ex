defmodule ExAccounting.Elem.ClearingDocumentFiscalYear do
  @moduledoc """
  _Clearing Document Fiscal Year_ is the fiscal year of the document that is reversed.
  """
  use ExAccounting.Type
  year(:fiscal_year, description: "Fiscal Year of cleared document")
end
