defmodule ExAccounting.Elem.Language do
  @moduledoc """
  _Language_ refers to the natural language used as a means of business communication.
  """
  use ExAccounting.Type
  code(:language, length: 2, description: "Language")
end

defmodule ExAccounting.Elem.Zip do
  use ExAccounting.Type
  code(:zip, length: 10, description: "Zip Code")
end
