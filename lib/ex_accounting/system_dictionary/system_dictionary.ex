defmodule ExAccounting.SystemDictionary.UserName do
  @moduledoc """
  TODO
  """

  @type t :: %__MODULE__{user_name: charlist}
  defstruct user_name: nil

  @doc """
    [create] is function for generating valid UserName.

  ## Examples

    iex> UserName.create(~C[skusunoki])
    %UserName{user_name: ~c[skusunoki]}

    iex> UserName.create("skusunoki")
    %UserName{user_name: ~c[skusunoki]}

    iex> UserName.create("ng_case,")
    {:error, "invalid_user_name"}
  """
  @spec create(charlist) :: t() | {:error, String.t()}
  def create(user_name) when is_list(user_name) and length(user_name) <= 16 do
    case validate_user_name(convert_to_lowercase(user_name)) do
      {:ok, user_name} -> %__MODULE__{user_name: user_name}
      {:ng, _user_name} -> {:error, "invalid_user_name"}
    end
  end

  def create(user_name) when is_binary(user_name) do
    user_name
    |> to_charlist
    |> create
  end

  @spec validate_user_name(charlist) :: {atom, charlist}
  defp validate_user_name(user_name) do
    valid_charactors = ~c[abcdefghijklmnopqrstuvwxyz0123456789_.]

    {
      user_name
      |> Enum.reduce(:ok, fn x, acc ->
        case x in valid_charactors do
          true -> acc
          false -> :ng
        end
      end),
      user_name
    }
  end

  @spec convert_to_lowercase(charlist) :: charlist
  defp convert_to_lowercase(upper_case_can_be_contained)
       when is_list(upper_case_can_be_contained) do
    upper_case_can_be_contained
    |> to_string
    |> String.downcase()
    |> to_charlist
  end
end
