defmodule ExAccounting.Elem.EnteredBy do
  @moduledoc """
  _Entered By_ is _User Name_ who inputs the accounting document.
  """
  use Ecto.Type

  @typedoc "_Entered By_"
  @type t :: %__MODULE__{entered_by: ExAccounting.Elem.UserName.t()}

  @typedoc "_User Name_"
  @type user_name :: ExAccounting.Elem.UserName.t()
  defstruct entered_by: nil

  @doc """
  Define database field type of _Entered By_
  """
  def type, do: :string

  @doc """
    Casts the given user name to the internal form of _Entered By_.

  ## Examples

      iex> "JohnDoe"
      ...> |> ExAccounting.Elem.UserName.create()
      ...> |> create()
      ...> |> cast()
      {:ok, %ExAccounting.Elem.EnteredBy{entered_by: %ExAccounting.Elem.UserName{user_name: ~C[johndoe] }}}
  """
  @spec cast(t | user_name) :: {:ok, t()} | :error
  def cast(%ExAccounting.Elem.EnteredBy{} = term) do
    with %ExAccounting.Elem.EnteredBy{entered_by: user_name} <- term,
         %ExAccounting.Elem.UserName{user_name: to_be_validated} <- user_name,
         {:ok, _validated} <-
           ExAccounting.Elem.UserName.validate_user_name(to_be_validated) do
      {:ok, term}
    else
      _ -> :error
    end
  end

  def cast(%ExAccounting.Elem.UserName{} = term) do
    with %ExAccounting.Elem.UserName{user_name: to_be_validated} <- term,
         {:ok, _validated} <-
           ExAccounting.Elem.UserName.validate_user_name(to_be_validated) do
      {:ok, create(term)}
    end
  end

  @doc """
    Generates valid EnteredBy.

  ## Exampels

      iex> create( ExAccounting.Elem.UserName.create(~C[JohnDoe]))
      %EnteredBy{entered_by: %ExAccounting.Elem.UserName{ user_name: ~C[johndoe]}}
  """
  @spec create(ExAccounting.Elem.UserName.t()) :: t()
  def create(%ExAccounting.Elem.UserName{} = entered_by) do
    %__MODULE__{entered_by: entered_by}
  end

  @doc """
  Dumps _Entered By into the database form.
  """
  @spec dump(t) :: binary() | :error
  def dump(%__MODULE__{} = term) do
    with %__MODULE__{entered_by: user_name} <- term,
         %ExAccounting.Elem.UserName{user_name: code} <- user_name do
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
           |> ExAccounting.Elem.UserName.create()
           |> create() do
      {:ok, entered_by}
    end
  end

  @doc """
  Convert to _Entered By_ to _User Name_.

  ## Examples

      iex> to_user_name(%EnteredBy{entered_by: %ExAccounting.Elem.UserName{user_name: ~C[johndoe]}})
      {:ok, %ExAccounting.Elem.UserName{user_name: ~C[johndoe]}}
  """
  @spec to_user_name(t) :: {:ok, user_name()} | :error
  def to_user_name(%__MODULE__{entered_by: user_name}) do
    {:ok, user_name}
  end

  def to_user_name(_), do: :error
end
