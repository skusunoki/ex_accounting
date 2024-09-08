defmodule ExAccounting.Elem.PostedBy do
  @moduledoc """
    _Entered By_ is the _User Name_ who posts the accounting document.
  """
  use Ecto.Type

  @typedoc "_Posted By_"
  @type t :: %__MODULE__{posted_by: ExAccounting.Elem.UserName.t()}

  @typedoc "_User Name_"
  @type user_name :: ExAccounting.Elem.UserName.t()
  defstruct posted_by: nil

  @doc """
  Define database field type of _Posted By_
  """
  @spec type() :: :string
  def type, do: :string

  @doc """
    Casts the given user name to the internal form of _Posted By_.

  ## Examples

      iex> "JohnDoe"
      ...> |> ExAccounting.Elem.UserName.create()
      ...> |> create()
      ...> |> cast()
      {:ok, %PostedBy{posted_by: %ExAccounting.Elem.UserName{user_name: ~C[johndoe] }}}
  """
  @spec cast(t | user_name) :: {:ok, t()} | :error
  def cast(%ExAccounting.Elem.PostedBy{} = term) do
    with %ExAccounting.Elem.PostedBy{posted_by: user_name} <- term,
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

  def cast(_), do: :error

  @doc """
  Dumps the _Posted By_ into the database form.

  ## Examples

      iex> dump(%PostedBy{posted_by: %ExAccounting.Elem.UserName{user_name: ~C[johndoe]}})
      {:ok, "johndoe"}
  """
  @spec dump(t) :: {:ok, String.t()} | :error
  def dump(%__MODULE__{posted_by: posted_by}), do: {:ok, posted_by.user_name |> to_string()}
  def dump(_), do: :error

  @doc """
  Loads the _Posted By_ from the database form.

  ## Examples

      iex> load("johndoe")
      {:ok, %PostedBy{posted_by: %ExAccounting.Elem.UserName{user_name: ~C[johndoe]}}}
  """
  @spec load(String.t()) :: {:ok, t()} | :error
  def load(posted_by) do
    case ExAccounting.Elem.UserName.load(posted_by) do
      {:ok, user_name} -> {:ok, %__MODULE__{posted_by: user_name}}
      :error -> :error
    end
  end

  @doc """
    Generates the valid _Posted By_ from _User Name_.

  ## Exampels

      iex> create( ExAccounting.Elem.UserName.create( ~C[JohnDoe]))
      %PostedBy{posted_by: %ExAccounting.Elem.UserName{ user_name: ~C[johndoe]}}
  """
  @spec create(user_name :: user_name) :: t()
  def create(%ExAccounting.Elem.UserName{} = user_name) do
    %__MODULE__{posted_by: user_name}
  end

  @doc """
  Convert to _Posted By_ to _User Name_.

  ## Examples

      iex> to_user_name(%PostedBy{posted_by: %ExAccounting.Elem.UserName{user_name: ~C[johndoe]}})
      {:ok, %ExAccounting.Elem.UserName{user_name: ~C[johndoe]}}
  """
  @spec to_user_name(t) :: {:ok, user_name()} | :error
  def to_user_name(%__MODULE__{posted_by: user_name}) do
    {:ok, user_name}
  end

  def to_user_name(_), do: :error
end
