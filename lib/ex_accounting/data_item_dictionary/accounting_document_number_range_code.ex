defmodule ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode do
  @moduledoc """
  Accounting Document Number Range Code controls document number issueed with in the defined ranges.
  Code should be 2 digits. Letters of code should be uppercase alphanumeric: A-Z or 0 - 9.
  """
  use Ecto.Type
  @type t :: %__MODULE__{accounting_document_number_range_code: String.t()}
  defstruct accounting_document_number_range_code: nil
  def type, do: :string

  @doc """
  Function [create] returns valid value of Accounting Document Number Range Code for string or charactor list argument.

  ## Examples

      iex> ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode.create("02")
      %ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode{accounting_document_number_range_code: "02"}

      iex> ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode.create("x1")
      {:error, "x1 is not valid"}
  """
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
      {:ok, validated} -> %__MODULE__{accounting_document_number_range_code: to_string(validated)}
      {:error, input} -> {:error, to_string(input) <> " is not valid"}
    end
  end

  @doc """
  ## Examples

    iex> import ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode
    iex> cast("02")
    {:ok, %ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode{accounting_document_number_range_code: "02"}}

    iex> import ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode
    iex> cast(~c"02")
    {:ok, %ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode{accounting_document_number_range_code: "02"}}

  """
  def cast(term) when is_list(term) and length(term) == 2 do
    case ExAccounting.Utility.validate(term) do
      {:ok, validated} -> {:ok, create(validated)}
      {:error, input} -> {:error, to_string(input)}
    end
  end

  def cast(term) when is_binary(term) do
    term
    |> to_charlist()
    |> cast()
  end

  def cast(%__MODULE__{accounting_document_number_range_code: _code} = term) do
    {:ok, term}
  end

  @doc """

  ## Examples

      iex> import ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode
      iex> dump(create("02"))
      {:ok, "02"}

      iex> import ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode
      iex> dump(~c"02")
      :error
  """
  def dump(%__MODULE__{accounting_document_number_range_code: code} = _data_item)
      when is_binary(code) do
    {:ok, code}
  end

  def dump(_) do
    :error
  end

  @doc """

  ## Examples

    iex> import ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode
    iex> load("02")
    {:ok, %ExAccounting.DataItemDictionary.AccountingDocumentNumberRangeCode{accounting_document_number_range_code: "02"}}

  """
  def load(db_data_item) do
    {:ok, create(db_data_item)}
  end
end
