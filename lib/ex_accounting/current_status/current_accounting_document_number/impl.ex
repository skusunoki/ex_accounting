defmodule ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber.Impl do
  alias ExAccounting.Elem.AccountingDocumentNumber
  alias ExAccounting.Elem.AccountingDocumentNumberRangeCode
  alias ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber

  @typedoc "Next document number which is incremented or newly created from the configuration of the accounting document number range."
  @type current_document_number :: %{
          number_range_code: AccountingDocumentNumberRangeCode.t(),
          current_document_number: AccountingDocumentNumber.t()
        }

  @doc """
  Increments the current document number by one.
  """
  @spec increment(current_document_number) :: current_document_number
  @spec increment(AccountingDocumentNumber.t()) :: AccountingDocumentNumber.t()
  @spec increment(CurrentAccountingDocumentNumber.t()) :: CurrentAccountingDocumentNumber.t()
  @spec increment(CurrentAccountingDocumentNumber.t(), [CurrentAccountingDocumentNumber.t()]) :: [
          CurrentAccountingDocumentNumber.t()
        ]
  def increment(%CurrentAccountingDocumentNumber{} = current_accounting_document_number) do
    with %CurrentAccountingDocumentNumber{
           current_document_number: current_document_number
         } <- current_accounting_document_number do
      Map.put(
        current_accounting_document_number,
        :current_document_number,
        increment(current_document_number)
      )
    end
  end

  def increment(%AccountingDocumentNumber{accounting_document_number: number}) do
    %AccountingDocumentNumber{accounting_document_number: number + 1}
  end

  def increment(
        %CurrentAccountingDocumentNumber{} = current_accounting_document_number,
        current_accounting_document_numbers
      ) do
    with incremented_current_accounting_document_number =
           increment(current_accounting_document_number) do
      current_accounting_document_numbers
      |> Enum.map(fn x ->
        case x.number_range_code == current_accounting_document_number.number_range_code do
          true -> incremented_current_accounting_document_number
          false -> x
        end
      end)
    end
  end

  @spec filter([CurrentAccountingDocumentNumber.t()], AccountingDocumentNumberRangeCode.t()) ::
          CurrentAccountingDocumentNumber.t() | nil
  def filter(current_accounting_document_numbers, number_range_code) do
    result =
      Enum.filter(current_accounting_document_numbers, fn current_accounting_document_number ->
        current_accounting_document_number.number_range_code.accounting_document_number_range_code ==
          number_range_code.accounting_document_number_range_code
      end)

    case result do
      [] -> nil
      [h | _t] -> h
    end
  end

  def initiate(number_range_code, db, current_accounting_document_numbers) do
    with [one | _] <- db,
         to_be_inserted = %CurrentAccountingDocumentNumber{
           number_range_code: number_range_code,
           current_document_number:
             ExAccounting.Elem.AccountingDocumentNumber.create(
               one.accounting_document_number_from
             )
         } do
      [to_be_inserted | current_accounting_document_numbers]
    end
  end
end
