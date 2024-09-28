defmodule ExAccounting.Elem.PostedBy do
  @moduledoc """
    _Entered By_ is the _User Name_ who posts the accounting document.
  """
  use ExAccounting.Type
  username(:user_name)

  @doc """
  Convert to _Posted By_ to _User Name_.

  ## Examples

      iex> to_user_name(%PostedBy{user_name: ~C[johndoe]})
      {:ok, %ExAccounting.Elem.UserName{user_name: ~C[johndoe]}}
  """
  @spec to_user_name(t) :: {:ok, ExAccounting.Elem.UserName} | :error
  def to_user_name(%__MODULE__{user_name: name} = _user_name) do
    with {:ok, user_name} <- ExAccounting.Elem.UserName.cast(name) do
      {:ok, user_name}
    else
      _ -> :error
    end
  end

  def to_user_name(_), do: :error
end
