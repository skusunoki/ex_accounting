defmodule Learning.UseMacro do
  use Learning.Type

  code(Example1, :example1, :string, 10)
  code(Example2, :example2, :string, 4)
  code(Example3, :example3, :string, 10)
end
