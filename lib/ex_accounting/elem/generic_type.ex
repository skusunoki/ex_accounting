defmodule ExAccounting.Elem.GenericType do
  use ExAccounting.Type

  # Defines custom types by the macro `code/4`
  code(Language, :language, :string, 2)
  code(Zip, :zip, :string, 13)
end
