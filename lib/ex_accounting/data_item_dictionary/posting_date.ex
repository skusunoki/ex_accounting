defmodule ExAccounting.DataItemDictionary.PostingDate do
  @moduledoc """
  _Posting Date_ is the date of accounting document posted.

  _Posting date_ must be consistent with accounting period within an accounting document.
  """
  use Ecto.Type

  @typedoc "__Posting Date__"
  @type t :: %__MODULE__{posting_date: Date.t()}
  defstruct posting_date: nil

  def type, do: :date

  @doc """
  Casts the given date in Elixir Date type to the date in the valid internal form.

  ## Examples

      iex> ExAccounting.DataItemDictionary.PostingDate.cast(~D[2024-08-01])
      {:ok, %ExAccounting.DataItemDictionary.PostingDate{posting_date: ~D[2024-08-01]}}
  """
  def cast(date) do
    with %Date{} <- date do
      {:ok, %__MODULE__{posting_date: date}}
    else
      _ -> :error
    end
  end

  @doc """
  Dumps the given date in the valid internal type into the Elixir Date type.

  ## Examples

      iex> ExAccounting.DataItemDictionary.PostingDate.dump(%ExAccounting.DataItemDictionary.PostingDate{posting_date: ~D[2024-08-01]})
      {:ok, ~D[2024-08-01]}
  """
  @spec dump(t) :: {:ok, Date.t()} | :error
  def dump(posting_date) do
    with %__MODULE__{posting_date: date} <- posting_date do
      {:ok, date}
    else
      _ -> :error
    end
  end

  def load(date) do
    with %Date{} <- date do
      {:ok, %__MODULE__{posting_date: date}}
    else
      _ -> {:error, date}
    end
  end

  @doc """
    Generates valid _Posting Date_ from the given date in Elixir Date type.

  ## Examples
      iex> PostingDate.create(~D[2024-08-03])
      %PostingDate{posting_date: ~D[2024-08-03]}
  """
  @spec create(Date.t()) :: t()
  def create(%Date{} = posting_date) do
    %__MODULE__{posting_date: posting_date}
  end
end
