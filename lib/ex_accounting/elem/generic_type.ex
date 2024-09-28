defmodule ExAccounting.Elem.Language do
  @moduledoc """
  _Language_ refers to the natural language used as a means of business communication.
  """
  use ExAccounting.Type
  code(:language, type: :string, length: 2)
end

defmodule ExAccounting.Elem.Zip do
  use ExAccounting.Type
  code(:zip, type: :string, length: 10)
end
