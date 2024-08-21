defmodule ExAccounting.DataItemDictionary.PostingDate do
  @moduledoc """
  PostingDate is the date of accounting document posted. Posting date should be consistent with accounting period.
  """
  use Ecto.Type

  @type t :: %__MODULE__{posting_date: Date.t()}
  defstruct posting_date: nil

  def type, do: :date

  def cast(date) do
    with %Date{} <- date do
      {:ok, %__MODULE__{posting_date: date}}
    else
      _ -> :error
    end
  end

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
    [create] is function for generating valid PostingDate.

  ## Examples
    iex> PostingDate.create(~D[2024-08-03])
    %PostingDate{posting_date: ~D[2024-08-03]}
  """
  @spec create(Date.t()) :: t()
  def create(%Date{} = posting_date) do
    %__MODULE__{posting_date: posting_date}
  end
end
