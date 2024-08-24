defmodule ExAccounting do
  @moduledoc """
  ExAccounting is a double-entry accounting application.

  Accounting data is recorded in the form of balanced journal entries to ensure the accuracy of ledgers.

  """
  alias ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber
  alias ExAccounting.DataItem.AccountingDocumentNumberRangeCode
  alias ExAccounting.Configuration.AccountingDocumentNumberRange

  @doc """
  An accounting document number is issued within the specified number range.

  """
  @spec issue_accounting_document_number(
          String.t(),
          CurrentAccountingDocumentNumber.read(),
          AccountingDocumentNumberRange.read()
        ) :: {:ok, any} | {:error, any}
  def issue_accounting_document_number(number_range_code, current_value_reader, config_reader) do
    with {:ok, code} <-
           number_range_code
           |> AccountingDocumentNumberRangeCode.cast(),
         {:ok, result} <-
           code
           |> CurrentAccountingDocumentNumber.issue(current_value_reader, config_reader)
           |> CurrentAccountingDocumentNumber.make_changeset()
           |> ExAccounting.Repo.upsert() do
      {:ok, result}
    end
  end
end
