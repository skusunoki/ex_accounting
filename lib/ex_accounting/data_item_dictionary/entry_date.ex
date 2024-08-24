defmodule ExAccounting.DataItemDictionary.EntryDate do
  @moduledoc """
  EntryDate is the date of document created.
  """

  @typedoc "_Entry Date_"
  @type t :: %__MODULE__{entry_date: Date.t()}
  defstruct entry_date: nil

  @doc """
    Generates the valid _Entry Date_ from the given date in Elixir Date type.

  ## Examples

      iex> EntryDate.create(~D[2024-08-03])
      %EntryDate{entry_date: ~D[2024-08-03]}
  """

  @spec create(Date.t()) :: t()
  def create(%Date{} = entry_date) do
    %__MODULE__{entry_date: entry_date}
  end
end
