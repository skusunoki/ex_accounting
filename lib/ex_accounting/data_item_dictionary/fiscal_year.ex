defmodule ExAccounting.DataItemDictionary.FiscalYear do
  @moduledoc """
  FiscalYear is time period for accounting cycle.
  """
  use Ecto.Type
  @type t :: %__MODULE__{fiscal_year: pos_integer}
  defstruct fiscal_year: nil

  @doc """

  ## Examples

      iex>ExAccounting.DataItemDictionary.FiscalYear.type
      :integer

  """
  def type, do: :integer

  @doc """
    [create] is function for generating valid FiscalYear.

  ## Examples

      iex> FiscalYear.create(2024)
      %FiscalYear{ fiscal_year: 2024 }
  """
  @spec create(pos_integer) :: t()
  def create(fiscal_year)
      when is_integer(fiscal_year) and fiscal_year > 0 and fiscal_year <= 9999 do
    %__MODULE__{fiscal_year: fiscal_year}
  end

  def cast(term) do
    with true <- is_integer(term),
         true <- term > 0,
         true <- term <= 9999 do
      {:ok, create(term)}
    else
      false -> {:error, term}
    end
  end

  def dump(%__MODULE__{} = term) do
    term.fiscal_year
  end

  def dump(_) do
    :error
  end

  def load(term) do
    {:ok, create(term)}
  end
end
