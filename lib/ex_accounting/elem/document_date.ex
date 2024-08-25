defmodule ExAccounting.Elem.DocumentDate do
  @moduledoc """
  DocumentDate is the date of document.
  """

  use Ecto.Type

  @typedoc "_Document Date_"
  @type t :: %__MODULE__{document_date: Date.t()}
  defstruct document_date: nil

  @doc """
  Defines the type of the _Document Date_ in database as date.

  ## Examples

      iex> DocumentDate.type()
      :date
  """
  @spec type() :: :date
  def type, do: :date

  @doc """
  Casts the given date to the _Document Date_.

  ## Examples

      iex> DocumentDate.cast(~D[2024-08-03])
      {:ok, %DocumentDate{document_date: ~D[2024-08-03]}}
  """
  @spec cast(t | Date.t()) :: {:ok, t()} | :error
  def cast(%__MODULE__{} = document_date) do
    {:ok, document_date}
  end

  def cast(%Date{} = document_date) do
    {:ok, %__MODULE__{document_date: document_date}}
  end

  def cast(_), do: :error

  @doc """
  Dumps the _Document Date_ to the date.

  ## Examples

      iex> DocumentDate.dump(%DocumentDate{document_date: ~D[2024-08-03]})
      {:ok, ~D[2024-08-03]}
  """
  @spec dump(t) :: {:ok, Date.t()} | :error
  def dump(%__MODULE__{document_date: document_date}), do: {:ok, document_date}
  def dump(_), do: :error

  @doc """
  Loads the _Document Data_ from the database form data.

  ## Examples

      iex> DocumentDate.load(~D[2024-08-03])
      {:ok, %DocumentDate{document_date: ~D[2024-08-03]}}
  """
  @spec load(Date.t()) :: {:ok, t()} | :error
  def load(%Date{} = document_date), do: {:ok, %__MODULE__{document_date: document_date}}
  def load(_), do: :error

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
