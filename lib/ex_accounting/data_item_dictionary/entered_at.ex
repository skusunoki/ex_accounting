defmodule ExAccounting.DataItemDictionary.EnteredAt do
  @moduledoc """
  EnteredAt is the time of the document created.
  """

  use Ecto.Type

  @typedoc "_Entered At_"
  @type t :: %__MODULE__{entered_at: Time.t()}
  defstruct entered_at: nil

  @doc """
  Defines the type of the _Entered At_ in database as time.

  ## Examples

      iex> EnteredAt.type()
      :time
  """
  @spec type() :: :time
  def type, do: :time

  @doc """
  Casts the given time to the _Entered At_.

  ## Examples

      iex> EnteredAt.cast(~T[12:34:56.00])
      {:ok, %EnteredAt{entered_at: ~T[12:34:56.00]}}
  """
  @spec cast(t | Time.t()) :: {:ok, t()} | :error
  def cast(%__MODULE__{} = entered_at) do
    {:ok, entered_at}
  end

  def cast(%Time{} = entered_at) do
    {:ok, %__MODULE__{entered_at: entered_at}}
  end

  def cast(_), do: :error

  @doc """
  Dumps the _Entered At_ to the time.

  ## Examples

      iex> EnteredAt.dump(%EnteredAt{entered_at: ~T[12:34:56.00]})
      {:ok, ~T[12:34:56.00]}
  """
  @spec dump(t) :: {:ok, Time.t()} | :error
  def dump(%__MODULE__{entered_at: entered_at}), do: {:ok, entered_at}
  def dump(_), do: :error

  @doc """
  Loads the _Entered At_ from the database form data.

  ## Examples

      iex> EnteredAt.load(~T[12:34:56.00])
      {:ok, %EnteredAt{entered_at: ~T[12:34:56.00]}}
  """
  @spec load(Time.t()) :: {:ok, t()} | :error
  def load(%Time{} = entered_at), do: {:ok, %__MODULE__{entered_at: entered_at}}
  def load(_), do: :error

  @doc """
    Generates the valid _Entered At_ from the given time in Elixir Time type.

  ## Examples

      iex> EnteredAt.create(~T[12:34:56.00])
      %EnteredAt{entered_at: ~T[12:34:56.00]}
  """
  @spec create(Time.t()) :: t()
  def create(%Time{} = entered_at) do
    %__MODULE__{entered_at: entered_at}
  end
end
