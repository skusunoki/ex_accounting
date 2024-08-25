defmodule ExAccounting.Elem.ReverseDocumentIndicator do
  @moduledoc """
  _Reverse Document Indicator_ is a flag to indicate that this document is a reversal of another document.
  """
  use Ecto.Type

  @typedoc "_Reverse Document Indicator_"
  @type t :: %__MODULE__{reverse_document_indicator: boolean}
  defstruct reverse_document_indicator: nil

  @doc """
  Defines the type of the _Reverse Document Indicator_ in database as boolean.
  """
  @spec type() :: :string
  def type, do: :string

  @doc """
  Casts the given boolean to the _Reverse Document Indicator_.

  ## Examples

      iex> cast(true)
      {:ok, %ReverseDocumentIndicator{reverse_document_indicator: true}}
  """
  @spec cast(boolean) :: {:ok, t()} | :error
  def cast(reverse_document_indicator) when is_boolean(reverse_document_indicator) do
    case reverse_document_indicator do
      true -> {:ok, %__MODULE__{reverse_document_indicator: true}}
      false -> {:ok, %__MODULE__{reverse_document_indicator: false}}
    end
  end

  def cast(_), do: :error

  @doc """
  Dumps the _Reverse Document Indicator_ to the boolean.

  ## Examples

      iex> dump(%ReverseDocumentIndicator{reverse_document_indicator: true})
      {:ok, "X"}
  """
  @spec dump(t) :: {:ok, boolean} | :error
  def dump(%__MODULE__{reverse_document_indicator: reverse_document_indicator}) do
    case reverse_document_indicator do
      true -> {:ok, "X"}
      false -> {:ok, " "}
    end
  end

  def dump(_), do: :error

  @doc """
  Loads the _Reverse Document Indicator_ from the database form data.

  ## Examples

      iex> load("X")
      {:ok, %ReverseDocumentIndicator{reverse_document_indicator: true}}
  """
  @spec load(String.t()) :: {:ok, t()} | {:error, boolean}
  def load(reverse_document_indicator) when is_binary(reverse_document_indicator) do
    with true <- reverse_document_indicator in ["X", " "] do
      case reverse_document_indicator do
        "X" -> {:ok, %__MODULE__{reverse_document_indicator: true}}
        " " -> {:ok, %__MODULE__{reverse_document_indicator: false}}
      end
    else
      _ -> :error
    end
  end

  def load(_), do: :error

  @doc """
  Returns the default value of the _Reverse Document Indicator_.

  ## Examples

      iex> default()
      %ReverseDocumentIndicator{reverse_document_indicator: false}
  """
  @spec default() :: t
  def default, do: %__MODULE__{reverse_document_indicator: false}
end
