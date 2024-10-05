defmodule ExAccounting.Elem.ReverseDocumentIndicator do
  @moduledoc """
  _Reverse Document Indicator_ is a flag to indicate that this document is a reversal of another document.
  """
  use ExAccounting.Type
  indicator(:reverse_document_indicator, description: "Reverse Document Indicator")
end
