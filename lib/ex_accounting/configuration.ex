defmodule ExAccounting.Configuration do
  @moduledoc """
  _Configuration_ module configures the ExAccounting system.

  ## Accounting Document Number Range

  The _accounting document number range_ is a range of numbers that are used to identify
  accounting documents; and has the first number and the last number of accounting document

  The _accounting document number range code_ is a unique identifier for the
  _accounting document number range_.

  The _accounting document number range_ can be created and changed by the following functions:
  - `create_accounting_document_number_range/3`
  - `change_accounting_document_number_range/3`



  """
  alias ExAccounting.Configuration.AccountingDocumentNumberRange
  alias ExAccounting.DataItem.AccountingDocumentNumberRangeCode

  @typedoc "_Accounting Document Number Range Code_"
  @type accounting_document_number_range_code :: AccountingDocumentNumberRangeCode.t()

  @doc """
  Creates the accounting document number range from the given number range code, the first number of accounting document, and the last number of accounting document.
  """
  @spec create_accounting_document_number_range(
          number_range_code ::
            accounting_document_number_range_code,
          accounting_document_number_from :: integer,
          accounting_document_number_to :: integer
        ) :: {:ok, AccountingDocumentNumberRange.t()} | {:error, Ecto.Changeset.t()}
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
  @spec change_accounting_document_number_range(
          number_range_code ::
            accounting_document_number_range_code,
          accounting_document_number_from :: integer,
          accounting_document_number_to :: integer
        ) :: {:ok, AccountingDocumentNumberRange.t()} | {:error, Ecto.Changeset.t()}
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
