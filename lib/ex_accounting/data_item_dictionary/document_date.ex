defmodule ExAccounting.DataItemDictionary.DocumentDate do
  @moduledoc """
  DocumentDate is the date of document.
  """

  @typedoc "_Document Date_"
  @type t :: %__MODULE__{document_date: Date.t()}
  defstruct document_date: nil

  @doc """
    Generates the valid _Document Date_ from the given date in Elixir Date type.

  ## Examples

      iex> DocumentDate.create(~D[2024-08-03])
      %DocumentDate{document_date: ~D[2024-08-03]}
  """
  @spec create(Date.t()) :: t()
  def create(%Date{} = document_date) do
    %__MODULE__{document_date: document_date}
  end
end
