defmodule ExAccounting.Elem.ReversedDocumentFiscalYear do
  @moduledoc """
  _Reversed Document Fiscal Year_ is the fiscal year of the document that is reversed.
  """
  use Ecto.Type
  alias ExAccounting.Elem.FiscalYear

  @typedoc "_Reversed Document Fiscal Year_"
  @type t :: %__MODULE__{reversed_document_fiscal_year: FiscalYear.t()}

  @typedoc "_Fiscal Year_"
  @type fiscal_year :: FiscalYear.t()
  defstruct reversed_document_fiscal_year: nil

  @doc """
  Defines the type of the _Reversed Document Fiscal Year_ in database as integer.

  ## Examples

      iex> ExAccounting.Elem.ReversedDocumentFiscalYear.type
      :integer

  """
  @spec type() :: :integer
  def type, do: :integer


  @doc """
  Casts the given _Fiscal Year_ to the _Reversed Document Fiscal Year_.

  ## Examples

      iex> ReversedDocumentFiscalYear.cast(%FiscalYear{ fiscal_year: 2024 })
      {:ok, %ReversedDocumentFiscalYear{ reversed_document_fiscal_year: %FiscalYear{ fiscal_year: 2024 }}}
  """
  @spec cast(t) :: {:ok, t()} | {:error, FiscalYear.t()}
  def cast(%__MODULE__{} = term) do
    with %FiscalYear{fiscal_year: code} <- term.reversed_document_fiscal_year,
         true <- is_integer(code),
         true <- code > 0,
         true <- code <= 9999 do
      {:ok, term}
    else
      _ -> :error
    end
  end

  def cast(%FiscalYear{} = term) do
    with %FiscalYear{fiscal_year: code} <- term,
         true <- is_integer(code),
         true <- code > 0,
         true <- code <= 9999 do
      {:ok, %__MODULE__{reversed_document_fiscal_year: term}}
    else
      _ -> :error
    end
  end

  def cast(term) do
    with true <- is_integer(term),
         true <- term > 0,
         true <- term <= 9999 do
      {:ok, %__MODULE__{reversed_document_fiscal_year: %FiscalYear{fiscal_year: term}}}
    else
      false -> {:error, term}
    end
  end

  @doc """
  Dumps the _Reversed Document Fiscal Year_ to the _Fiscal Year_.

  ## Examples

      iex> ReversedDocumentFiscalYear.dump(%ReversedDocumentFiscalYear{ reversed_document_fiscal_year: %FiscalYear{ fiscal_year: 2024 } })
      {:ok, %FiscalYear{ fiscal_year: 2024 }}
  """
  @spec dump(t) :: {:ok, integer} | :error
  def dump(%__MODULE__{reversed_document_fiscal_year: %FiscalYear{fiscal_year: fiscal_year}}),
    do: {:ok, fiscal_year}

  def dump(_), do: :error

  @doc """
  Loads the _Reversed Document Fiscal Year_ from the given database form data.

  ## Examples

      iex> ReversedDocumentFiscalYear.load(2024)
      {:ok, %ReversedDocumentFiscalYear{ reversed_document_fiscal_year: %FiscalYear{ fiscal_year: 2024 } }}
  """
  @spec load(integer) :: {:ok, t} | :error
  def load(reversed_document_fiscal_year) do
    with int_data = %{
           reversed_document_fiscal_year: %FiscalYear{fiscal_year: reversed_document_fiscal_year}
         } do
      {:ok, struct!(__MODULE__, int_data)}
    end
  end
end
