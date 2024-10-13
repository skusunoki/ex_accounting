defmodule ExAccounting.Configuration.AccountingArea.AccountingDocumentNumberRange do
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

  use Ecto.Schema
  alias ExAccounting.Elem.AccountingDocumentNumberRangeCode
  alias ExAccounting.Elem.AccountingDocumentNumber
  import Ecto.Changeset

  @typedoc "_Accounting Document Number Range_"
  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer() | nil,
          number_range_code: AccountingDocumentNumberRangeCode.t() | nil,
          accounting_document_number_from: AccountingDocumentNumber.t() | nil,
          accounting_document_number_to: AccountingDocumentNumber.t() | nil
        }

  @typedoc "_Accounting Document Number Range Code_"
  @type number_range_code :: ExAccounting.Elem.AccountingDocumentNumberRangeCode.t()

  @typedoc "Function to read number range: _Accounting Document Number Range Code_ -> _Accounting Document Number Range_"
  @type read :: (number_range_code -> t)

  @typedoc "_Accounting Document Number Range Code_"
  @type accounting_document_number_range_code :: AccountingDocumentNumberRangeCode.t()

  schema "accounting_document_number_ranges" do
    field(:number_range_code, ExAccounting.Elem.AccountingDocumentNumberRangeCode)
    field(:accounting_document_number_from, ExAccounting.Elem.AccountingDocumentNumber)
    field(:accounting_document_number_to, ExAccounting.Elem.AccountingDocumentNumber)
    belongs_to(:accounting_area, ExAccounting.Configuration.AccountingArea)
  end

  def changeset(accounting_document_number_range, params) do
    accounting_document_number_range
    |> cast(params, [
      :number_range_code,
      :accounting_document_number_from,
      :accounting_document_number_to
    ])
    |> validate_required([
      :number_range_code,
      :accounting_document_number_from,
      :accounting_document_number_to
    ])
    |> unique_constraint([:number_range_code, :accounting_area])
  end
end
