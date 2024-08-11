defmodule ExAccounting.DataItemDictionary.FiscalYear do
  @moduledoc """
  FiscalYear is time period for accounting cycle.
  """
  @type t :: %__MODULE__{fiscal_year: pos_integer}
  defstruct fiscal_year: nil

  @doc """
    [create] is function for generating valid FiscalYear.

  ## Examples

      iex> FiscalYear.create(2024)
      %FiscalYear{ fiscal_year: 2024 }
  """
  @spec create(pos_integer) :: t()
  def create(fiscal_year)
      when is_integer(fiscal_year) and fiscal_year > 0 and fiscal_year < 9999 do
    %__MODULE__{fiscal_year: fiscal_year}
  end
end
