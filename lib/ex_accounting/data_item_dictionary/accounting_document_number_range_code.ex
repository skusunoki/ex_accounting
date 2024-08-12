defmodule ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode do
  @moduledoc """
  TODO
  """
  @type t :: String.t()

  @spec create(String.t()) :: t()
  def create(accounting_document_number_range_code)
      when is_binary(accounting_document_number_range_code) do
    accounting_document_number_range_code
    |> to_charlist()
    |> create()
  end

  @spec create(list) :: t()
  def create(accounting_document_number_range_code)
      when is_list(accounting_document_number_range_code) and
             length(accounting_document_number_range_code) == 2 do
    case ExAccounting.Utility.validate(accounting_document_number_range_code) do
      {:ok, validated} -> to_string(validated)
      {:error, input} -> {:error, to_string(input) <> " is not valid"}
    end
  end
end
