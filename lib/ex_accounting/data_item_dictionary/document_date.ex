defmodule ExAccounting.DataItemDictionary.DocumentDate do
  @moduledoc """
  DocumentDate is the date of document.
  """

  @type t :: %__MODULE__{document_date: Date.t()}
  defstruct document_date: nil

  @doc """
    [create] is function for generating valid DocumentDate.

  ## Examples
    iex> DocumentDate.create(~D[2024-08-03])
    %DocumentDate{document_date: ~D[2024-08-03]}
  """
  @spec create(Date.t()) :: t()
  def create(%Date{} = document_date) do
    %__MODULE__{document_date: document_date}
  end
end
