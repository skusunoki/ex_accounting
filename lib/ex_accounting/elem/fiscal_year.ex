defmodule ExAccounting.Elem.FiscalYear do
  @moduledoc """
  FiscalYear is time period for accounting cycle.
  """
  use ExAccounting.Type
  year(:fiscal_year)

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
