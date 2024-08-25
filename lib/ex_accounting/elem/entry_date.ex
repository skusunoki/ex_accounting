defmodule ExAccounting.Elem.EntryDate do
  @moduledoc """
  EntryDate is the date of document created.
  """
  use Ecto.Type

  @typedoc "_Entry Date_"
  @type t :: %__MODULE__{entry_date: Date.t()}
  defstruct entry_date: nil

  @doc """
  Defines the database field type of _Entry Date_.

  ## Examples

      iex> type()
      :date
  """
  @spec type() :: :date
  def type, do: :date

  @doc """
  Casts the given date to the internal form of _Entry Date_.

  ## Examples

      iex> cast(~D[2024-08-03])
      {:ok, %EntryDate{entry_date: ~D[2024-08-03]}}

      iex> cast(%EntryDate{entry_date: ~D[2024-08-03]})
      {:ok, %EntryDate{entry_date: ~D[2024-08-03]}}
  """
  @spec cast(Date.t()) :: {:ok, t} | :error
  @spec cast(t) :: {:ok, t}
  def cast(%Date{} = term) do
    {:ok, %__MODULE__{entry_date: term}}
  end

  def cast(%__MODULE__{} = term) do
    with %__MODULE__{entry_date: date} <- term,
         %Date{} <- date do
      {:ok, term}
    else
      _ -> :error
    end
  end

  @doc """
  Dumps _Entry Date_ into the database form.

  ## Examples

      iex> dump(%EntryDate{entry_date: ~D[2024-08-03]})
      ~D[2024-08-03]
  """
  @spec dump(t) :: Date.t() | :error
  def dump(%__MODULE__{} = term) do
    term.entry_date
  end

  @doc """
  Loads the _Entry Date_ from the database form.

  ## Examples

      iex> load(~D[2024-08-03])
      {:ok, %EntryDate{entry_date: ~D[2024-08-03]}}
  """
  @spec load(Date.t()) :: t() | :error
  def load(entry_date) do
    with %Date{} <- entry_date do
      {:ok, %__MODULE__{entry_date: entry_date}}
    else
      _ -> :error
    end
  end

  @doc """
    Generates the valid _Entry Date_ from the given date in Elixir Date type.

  ## Examples

      iex> create(~D[2024-08-03])
      %EntryDate{entry_date: ~D[2024-08-03]}
  """
  @spec create(Date.t()) :: t()
  def create(%Date{} = entry_date) do
    %__MODULE__{entry_date: entry_date}
  end
end
