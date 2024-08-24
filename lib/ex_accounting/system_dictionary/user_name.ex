defmodule ExAccounting.SystemDictionary.UserName do
  @moduledoc """
  _User Name_ represents responsibility of the business processes.

  Any _User_s has its own name. It must be different.
  """

  use Ecto.Type

  @typedoc "_User Name_"
  @type t :: %__MODULE__{user_name: charlist}
  defstruct user_name: nil

  def type, do: :string

  def cast(%__MODULE__{} = term) do
    {:ok, term}
  end

  def cast(term) do
    with true <- is_list(term) or is_binary(term),
    true <- ExAccounting.Utility.len(term) <= 16,
    code = ExAccounting.Utility.to_c(term) |> convert_to_lowercase(),
    {:ok, _validated} <- validate_user_name(code)
     do
      {:ok, create(code)}
    else
      _ -> :error
    end

  end

  def dump(term) do
    with %__MODULE__{user_name: code} <- term do
      code
      |> to_string()
    else
      _ -> :error
    end
  end

  @doc """
  Loads data to _User Name_ in the valid internal form.

  ## Examples

      iex> ExAccounting.SystemDictionary.UserName.load("johndoe")
      {:ok, %ExAccounting.SystemDictionary.UserName{user_name: ~c[johndoe]}}
  """
  def load(data) do
    {:ok, create(data)}
  end

  @doc """
    Generates the valid _User Name_ from the given charlist or strings.

    The length of _User Name_ must be less than or equals to 16.
    The letters of alphanumeric, underscore(\_), or dot(.) are allowed.

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
      {:error, _user_name} -> {:error, "invalid_user_name"}
    end
  end

  def create(user_name) when is_binary(user_name) do
    user_name
    |> to_charlist
    |> create
  end

  @doc """
  Validates the given user name in charlist.
  Checks if the argument has only alphanumeric letters, underscore(\_), or dot(.).

  ## Examples

      iex> ExAccounting.SystemDictionary.UserName.validate_user_name(~C[JohnDoe])
      {:error, ~C[JohnDoe]}

      iex> ExAccounting.SystemDictionary.UserName.validate_user_name(~C[johndoe])
      {:ok, ~C[johndoe]}
  """
  @spec validate_user_name(charlist) :: {atom, charlist}
  def validate_user_name(user_name) do
    valid_charactors = ~c[abcdefghijklmnopqrstuvwxyz0123456789_.]

    {
      user_name
      |> Enum.reduce(:ok, fn x, acc ->
        case x in valid_charactors do
          true -> acc
          false -> :error
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
