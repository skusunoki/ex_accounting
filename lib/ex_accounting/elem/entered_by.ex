defmodule ExAccounting.Elem.EnteredBy do
  @moduledoc """
  _Entered By_ is _User Name_ who inputs the accounting document.
  """
  use ExAccounting.Type
  username :user_name

  @doc """
  Convert to _Entered By_ to _User Name_.

  ## Examples

      iex> to_user_name(%EnteredBy{user_name: ~C[johndoe]})
      {:ok, %ExAccounting.Elem.UserName{user_name: ~C[johndoe]}}
  """
  @spec to_user_name(t) :: ExAccounting.Elem.UserName.t() | :error
  def to_user_name(%__MODULE__{user_name: user_name}) do
    with {:ok, user_name} <- ExAccounting.Elem.UserName.cast(user_name) do
      {:ok, user_name}
    else
      _ -> :error
    end
  end

  def to_user_name(_), do: :error
end
