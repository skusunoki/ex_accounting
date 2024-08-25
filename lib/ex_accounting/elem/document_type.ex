defmodule ExAccounting.Elem.DocumentType do
  @moduledoc """
  _Document Type_ categorizes accounting document from the point of view of accounting business process.
  """

  use Ecto.Type

  @typedoc "_Document Type_"
  @type t :: %__MODULE__{document_type: charlist}
  defstruct document_type: nil

  @doc """
  Defines the type of the _Document Type_ in database as string.

  ## Examples

      iex> type()
      :string
  """
  @spec type() :: :string
  def type, do: :string

  @doc """
  Casts the given charlist to the _Document Type_.

  ## Examples

      iex> cast(~C[DR])
      {:ok, %DocumentType{document_type: ~C[DR]}}
  """
  @spec cast(t | charlist) :: {:ok, t()} | :error
  def cast(%__MODULE__{} = document_type) do
    {:ok, document_type}
  end

  def cast(document_type) when is_list(document_type) do
    with {:ok, _} <- ExAccounting.Utility.validate(document_type),
         true <- length(document_type) == 2 do
      {:ok, create(document_type)}
    else
      _ -> :error
    end
  end

  @doc """
  Dumps the _Document Type_ to the string.

  ## Examples

      iex> dump(%DocumentType{document_type: ~C[DR]})
      {:ok, "DR"}
  """
  @spec dump(t) :: {:ok, String.t()} | :error
  def dump(%__MODULE__{document_type: document_type}), do: {:ok, to_string(document_type)}
  def dump(_), do: :error

  @doc """
  Loads the _Document Type_ from the database form data.

  ## Examples

      iex> load("DR")
      {:ok, %DocumentType{document_type: ~C[DR]}}
  """
  @spec load(String.t()) :: {:ok, t()} | :error
  def load(document_type) when is_binary(document_type) do
    {:ok, struct!(__MODULE__, document_type: String.to_charlist(document_type))}
  end

  def load(_), do: :error

  @doc """
    Generates the valid _Document Type_ from the given charlist.

    The argument must be 2 letters. Strings is not allowed.

  ## Examples
      iex> create( ~C[DR] )
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
