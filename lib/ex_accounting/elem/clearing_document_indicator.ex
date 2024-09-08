defmodule ExAccounting.Elem.ClearingDocumentIndicator do
  @moduledoc """
  _Clearing Document Indicator_ is a flag to indicate that this document is a clearing of another document.
  """
  use Ecto.Type

  @typedoc "_Clearing Document Indicator_"
  @type t :: %__MODULE__{clearing_document_indicator: boolean}
  defstruct clearing_document_indicator: nil

  @doc """
  Defines the type of the _Clearing Document Indicator_ in database as boolean.
  """
  @spec type() :: :string
  def type, do: :string

  @doc """
  Casts the given boolean to the _Clearing Document Indicator_.

  ## Examples

      iex> cast(true)
      {:ok, %ClearingDocumentIndicator{clearing_document_indicator: true}}
  """
  @spec cast(boolean) :: {:ok, t()} | :error
  def cast(clearing_document_indicator) when is_boolean(clearing_document_indicator) do
    case clearing_document_indicator do
      true -> {:ok, %__MODULE__{clearing_document_indicator: true}}
      false -> {:ok, %__MODULE__{clearing_document_indicator: false}}
    end
  end

  def cast(_), do: :error

  @doc """
  Dumps the _Clearing Document Indicator_ to the boolean.

  ## Examples

      iex> dump(%ClearingDocumentIndicator{clearing_document_indicator: true})
      {:ok, "X"}
  """
  @spec dump(t) :: {:ok, boolean} | :error
  def dump(%__MODULE__{clearing_document_indicator: clearing_document_indicator}) do
    case clearing_document_indicator do
      true -> {:ok, "X"}
      false -> {:ok, " "}
    end
  end

  def dump(_), do: :error

  @doc """
  Loads the _Clearing Document Indicator_ from the database form data.

  ## Examples

      iex> load("X")
      {:ok, %ClearingDocumentIndicator{clearing_document_indicator: true}}
  """
  @spec load(String.t()) :: {:ok, t()} | {:error, boolean}
  def load(clearing_document_indicator) when is_binary(clearing_document_indicator) do
    with true <- clearing_document_indicator in ["X", " "] do
      case clearing_document_indicator do
        "X" -> {:ok, %__MODULE__{clearing_document_indicator: true}}
        " " -> {:ok, %__MODULE__{clearing_document_indicator: false}}
      end
    else
      _ -> :error
    end
  end

  def load(_), do: :error

  @doc """
  Returns the default value of the _Clearing Document Indicator_.

  ## Examples

      iex> default()
      %ClearingDocumentIndicator{clearing_document_indicator: false}
  """
  @spec default() :: t
  def default, do: %__MODULE__{clearing_document_indicator: false}
end
