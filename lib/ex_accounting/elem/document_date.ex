defmodule ExAccounting.Elem.DocumentDate do
  @moduledoc """
  _Document Date_ is the date on the original document.
  """

  use ExAccounting.Type
  date(:document_date, description: "Document Date")
end
