defmodule ExAccounting do
  @moduledoc """
  Documentation for `ExAccounting`.
  """
  alias ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber
  alias ExAccounting.Configuration.AccountingDocumentNumberRange
  alias ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode

  @spec issue_accounting_document_number(AccountingDocumentNumberRangeCode.t()) ::
          {:ok, any} | {:error, any}
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
