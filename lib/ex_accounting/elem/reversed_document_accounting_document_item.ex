defmodule ExAccounting.Elem.ReversedDocumentAccountingDocumentItem do
  @moduledoc """
  _Reversed Document Accounting Document Item_ is the _Accounting Document Item_ of the _Reversed Document Accounting Document_.
  """

  use ExAccounting.Type
  sequence(:accounting_document_item, type: :integer, max: 999_999)
end
