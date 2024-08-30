defmodule ExAccounting.Configuration.AccountingDocumentNumberRange.Impl do
  import Ecto.Changeset
  alias ExAccounting.Configuration.AccountingDocumentNumberRange
  alias ExAccounting.Configuration.AccountingDocumentNumberRange.Changeset

  def modify(
        accounting_document_number_ranges,
        accounting_document_number_range_code,
        accounting_document_number_from,
        accounting_document_number_to
      ) do
    case Enum.find(accounting_document_number_ranges, fn accounting_document_number_range ->
           accounting_document_number_range.number_range_code ==
             accounting_document_number_range_code
         end) do
      nil ->
        with added =
               %AccountingDocumentNumberRange{}
               |> Changeset.changeset(%{
                 number_range_code: accounting_document_number_range_code,
                 accounting_document_number_from: accounting_document_number_from,
                 accounting_document_number_to: accounting_document_number_to
               })
               |> apply_changes() do
          accounting_document_number_ranges ++ [added]
        end

      code ->
        with accounting_document_number_range =
               code
               |> Changeset.changeset(%{
                 number_range_code: accounting_document_number_range_code,
                 accounting_document_number_from: accounting_document_number_from,
                 accounting_document_number_to: accounting_document_number_to
               })
               |> apply_changes() do
          accounting_document_number_ranges -- ([code] ++ [accounting_document_number_range])
        end
    end
  end

  @doc """
  Add a new accounting document number range.
  """
  @spec create() :: AccountingDocumentNumberRange.t()
  def create() do
    %AccountingDocumentNumberRange{}
  end
end
