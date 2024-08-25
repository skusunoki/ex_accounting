defmodule ExAccounting.Elem.EnteredBy do
  @moduledoc """
  _Entered By_ is who inputs the accounting document.
  """
  use Ecto.Type

  @typedoc "_Entered By_"
  @type t :: %__MODULE__{entered_by: ExAccounting.SystemDictionary.UserName.t()}

  @typedoc "_User Name_"
  @type user_name :: ExAccounting.SystemDictionary.UserName.t()
  defstruct entered_by: nil

  @doc """
  Define database field type of _Entered By_
  """
  def type, do: :string

  @doc """
    Casts the given user name to the internal form of _Entered By_.

  ## Examples

      iex> "JohnDoe"
      ...> |> ExAccounting.SystemDictionary.UserName.create()
      ...> |> ExAccounting.Elem.EnteredBy.create()
      ...> |> ExAccounting.Elem.EnteredBy.cast()
      {:ok, %ExAccounting.Elem.EnteredBy{entered_by: %ExAccounting.SystemDictionary.UserName{user_name: ~C[johndoe] }}}
  """
  @spec cast(t | user_name) :: {:ok, t()} | :error
  def cast(%ExAccounting.Elem.EnteredBy{} = term) do
    with %ExAccounting.Elem.EnteredBy{entered_by: user_name} <- term,
         %ExAccounting.SystemDictionary.UserName{user_name: to_be_validated} <- user_name,
         {:ok, _validated} <-
           ExAccounting.SystemDictionary.UserName.validate_user_name(to_be_validated) do
      {:ok, term}
    else
      _ -> :error
    end
  end

  def cast(%ExAccounting.SystemDictionary.UserName{} = term) do
    with %ExAccounting.SystemDictionary.UserName{user_name: to_be_validated} <- term,
         {:ok, _validated} <-
           ExAccounting.SystemDictionary.UserName.validate_user_name(to_be_validated) do
      {:ok, create(term)}
    end
  end

  @doc """
    Generates valid EnteredBy.

  ## Exampels

      iex> EnteredBy.create( ExAccounting.SystemDictionary.UserName.create(~C[JohnDoe]))
      %EnteredBy{entered_by: %ExAccounting.SystemDictionary.UserName{ user_name: ~C[johndoe]}}
  """
  @spec create(ExAccounting.SystemDictionary.UserName.t()) :: t()
  def create(%ExAccounting.SystemDictionary.UserName{} = entered_by) do
    %__MODULE__{entered_by: entered_by}
  end

  @doc """
  Dumps _Entered By into the database form.
  """
  @spec dump(t) :: binary() | :error
  def dump(%__MODULE__{} = term) do
    with %__MODULE__{entered_by: user_name} <- term,
         %ExAccounting.SystemDictionary.UserName{user_name: code} <- user_name do
      {:ok, to_string(code)}
    end
  end

  @doc """
  Loads db data to _Entered By_ in the valid internal form.
  """
  @spec load(String.t() | charlist) :: {:ok, t}
  def load(term) do
    with entered_by =
           term
           |> ExAccounting.SystemDictionary.UserName.create()
           |> ExAccounting.Elem.EnteredBy.create() do
      {:ok, entered_by}
    end
  end
end
