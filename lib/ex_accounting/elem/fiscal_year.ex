defmodule ExAccounting.Elem.FiscalYear do
  @moduledoc """
  FiscalYear is time period for accounting cycle.

  ## Examples

      iex> cast(2020)
      {:ok, %ExAccounting.Elem.FiscalYear{fiscal_year: 2020}}

      iex> load(2020)
      {:ok, %ExAccounting.Elem.FiscalYear{fiscal_year: 2020}}

      iex> dump(%ExAccounting.Elem.FiscalYear{fiscal_year: 2020})
      {:ok, 2020}
  """

  use ExAccounting.Type
  year(:fiscal_year, description: "Fiscal Year")

  @doc """
  Casts the Fiscal Year to the Fiscal Year of Reversed Document.

  ## Examples

        iex> with {:ok, fiscal_year} <- ExAccounting.Elem.FiscalYear.cast(2020), do: fiscal_year |> to_reversed_document_fiscal_year
        {:ok, %ExAccounting.Elem.ReversedDocumentFiscalYear{fiscal_year: 2020}}
  """

  @spec to_reversed_document_fiscal_year(t) ::
          {:ok, ExAccounting.Elem.ReversedDocumentFiscalYear.t()} | :error
  def to_reversed_document_fiscal_year(%__MODULE__{fiscal_year: year} = _fiscal_year) do
    with {:ok, fiscal_year} <- ExAccounting.Elem.ReversedDocumentFiscalYear.cast(year) do
      {:ok, fiscal_year}
    else
      _ -> :error
    end
  end
end
