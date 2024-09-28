defmodule ExAccounting.Elem.EntryDate do
  @moduledoc """
  EntryDate is the date of document created.
  """
  use ExAccounting.Type
  date(:entry_date)
end
