defmodule ExAccounting.Elem.ReversedDocumentFiscalYear do
  @moduledoc """
  _Reversed Document Fiscal Year_ is the fiscal year of the document that is reversed.
  """
  use ExAccounting.Type
  year(:fiscal_year, description: "Fiscal Year of reversed document")

  def to_fiscal_year(%__MODULE__{fiscal_year: year} = _fiscal_year) do
    with {:ok, fiscal_year} <- ExAccounting.Elem.FiscalYear.cast(year) do
      {:ok, fiscal_year}
    else
      _ -> :error
    end
  end
end
