defmodule ExAccounting.Elem.ClearingDocumentIndicator do
  @moduledoc """
  _Clearing Document Indicator_ is a flag to indicate that this document is a clearing of another document.
  """
  use ExAccounting.Type
  indicator(:clearing_document_indicator, description: "Clearing Document Indicator")
end
