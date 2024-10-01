defmodule ExAccounting.Elem.DocumentDate do
  @moduledoc """
  DocumentDate is the date of document.
  """

  use ExAccounting.Type
  date(:document_date, description: "Document Date")
end
