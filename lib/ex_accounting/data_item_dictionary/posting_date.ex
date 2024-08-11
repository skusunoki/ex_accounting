defmodule ExAccounting.DataItemDictionary.PostingDate do
  @moduledoc """
  PostingDate is the date of accounting document posted. Posting date should be consistent with accounting period.
  """

  @type t :: %__MODULE__{posting_date: Date.t()}
  defstruct posting_date: nil

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
