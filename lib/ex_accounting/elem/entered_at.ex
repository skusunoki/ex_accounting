defmodule ExAccounting.Elem.EnteredAt do
  @moduledoc """
  EnteredAt is the time of the document created.
  """
  use ExAccounting.Type
  time(:entered_at)
end
