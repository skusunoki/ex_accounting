defmodule ExAccounting do
  @moduledoc """
  ExAccounting is a double-entry accounting application.

  Accounting data is recorded in the form of balanced journal entries to ensure the accuracy of ledgers.

  """
  alias ExAccounting.State.CurrentAccountingDocumentNumber
  alias ExAccounting.Elem.AccountingDocumentNumberRangeCode
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
         result <-
           code
           |> CurrentAccountingDocumentNumber.issue(current_value_reader, config_reader),
         {:ok, _} <- CurrentAccountingDocumentNumber.save() do
      {:ok, result}
    end
  end

  def issue_accounting_document_number(number_range_code) do
    with current_value_reader <- &CurrentAccountingDocumentNumber.read/1,
         config_reader <- &AccountingDocumentNumberRange.read/1 do
      issue_accounting_document_number(number_range_code, current_value_reader, config_reader)
    end
  end
end
