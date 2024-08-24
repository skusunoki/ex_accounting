defmodule ExAccounting.DataItemDictionary.DocumentType do
  @moduledoc """
  DocumentType categorize accounting document from the point of view of accounting business process.
  """

  @typedoc "_Document Type_"
  @type t :: %__MODULE__{document_type: charlist}
  defstruct document_type: nil

  @doc """
    [create] is function for generating valid document type.

  ## Examples
    iex> DocumentType.create( ~C[DR] )
    %DocumentType{ document_type: ~C[DR]}
  """
  @spec create(charlist) :: t()
  def create(document_type) when is_list(document_type) and length(document_type) == 2 do
    case ExAccounting.Utility.validate(document_type) do
      {:ok, validated} -> %__MODULE__{document_type: validated}
      {:error, input} -> {:error, to_string(input) <> " is not valid"}
    end
  end
end
