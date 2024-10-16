defmodule ExAccounting.Elem.DocumentType do
  @moduledoc """
  _Document Type_ categorizes accounting document from the point of view of accounting business process.
  """

  use ExAccounting.Type
  code(:document_type, length: 2, description: "Document Type")
end
