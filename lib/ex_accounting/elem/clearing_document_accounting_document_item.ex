defmodule ExAccounting.Elem.ClearingDocumentAccountingDocumentItem do
  @moduledoc """
  _Clearing Document Accounting Document Item_ is the _Accounting Document Item_ of the _Clearing Document Accounting Document_.
  """

  use ExAccounting.Type
  sequence(:accounting_document_item, type: :integer, max: 999_999)
end
