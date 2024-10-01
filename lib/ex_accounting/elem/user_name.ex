defmodule ExAccounting.Elem.UserName do
  @moduledoc """
  _User Name_ represents individual responsibility of the business processes.

  Any _User_ has its own name. It must be different from other _Users_.
  """

  use ExAccounting.Type
  username(:user_name, description: "User Name")
end
