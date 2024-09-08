defmodule ExAccounting.Schema.ReverseDocument do
  defstruct [
    :reverse_document_indicator,
    :reversed_document_accounting_unit,
    :reversed_document_accounting_document,
    :reversed_document_accounting_document_item,
    :reversed_document_accounting_period
  ]
end
