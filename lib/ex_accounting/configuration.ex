defmodule ExAccounting.Configuration do
  alias ExAccounting.Configuration.AccountingDocumentNumberRange

  @doc """
  Creates the accounting document number range from the given number range code, the first number of accounting document, and the last number of accounting document.
  """
  # TODO @spec create_accounting_document_number_range( number_range_code :: )
  def create_accounting_document_number_range(
        number_range_code,
        accounting_document_number_from,
        accounting_document_number_to
      ) do
    AccountingDocumentNumberRange.create()
    |> AccountingDocumentNumberRange.changeset(%{
      number_range_code: number_range_code,
      accounting_document_number_from: accounting_document_number_from,
      accounting_document_number_to: accounting_document_number_to
    })
    |> ExAccounting.Repo.insert()
  end

  @doc """
  Changes the accounting document number range from the given number range code, the first number of accounting document, and the last number of accounting document.
  """
  def change_accounting_document_number_range(
        number_range_code,
        accounting_document_number_from,
        accounting_document_number_to
      ) do
    AccountingDocumentNumberRange.read(number_range_code)
    |> AccountingDocumentNumberRange.changeset(%{
      number_range_code: number_range_code,
      accounting_document_number_from: accounting_document_number_from,
      accounting_document_number_to: accounting_document_number_to
    })
    |> ExAccounting.Repo.update()
  end
end
