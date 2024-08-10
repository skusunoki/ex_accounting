defmodule ExAccounting do
  @moduledoc """
  Documentation for `ExAccounting`.
  """
  alias ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber
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

  def issue_accounting_document_number(number_range_code) do
    number_range_code
    |> CurrentAccountingDocumentNumber.issue(
      &CurrentAccountingDocumentNumber.read(&1),
      &AccountingDocumentNumberRange.read(&1)
    )
    |> CurrentAccountingDocumentNumber.make_changeset()
    |> ExAccounting.Repo.upsert()
  end
end
