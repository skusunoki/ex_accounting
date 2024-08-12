defmodule ExAccounting.Configuration do
  alias ExAccounting.Configuration.AccountingDocumentNumberRange

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
