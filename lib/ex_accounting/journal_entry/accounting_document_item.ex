defmodule ExAccounting.JournalEntry.AccountingDocumentItem do
  @moduledoc """
  _Accounting Document Item_ is atomic data object in the accounting system.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias ExAccounting.Elem.AccountingUnit

  alias ExAccounting.Elem.{
    FiscalYear,
    AccountingArea,
    AccountingDocumentNumber,
    AccountingDocumentItemNumber,
    DebitCredit,
    DocumentType,
    PostingDate,
    AccountingPeriod,
    DocumentDate,
    EntryDate,
    EnteredAt,
    EnteredBy,
    PostedBy,
    ReverseDocumentIndicator
  }

  @type t :: %__MODULE__{
          fiscal_year: FiscalYear.t(),
          accounting_area: AccountingArea.t(),
          accounting_document_number: AccountingDocumentNumber.t(),
          accounting_unit: String.t(),
          accounting_document_item_number: AccountingDocumentItemNumber.t(),
          debit_credit: DebitCredit.t(),
          document_type: DocumentType.t(),
          posting_date: PostingDate.t(),
          accounting_period: AccountingPeriod.t(),
          document_date: DocumentDate.t(),
          entry_date: EntryDate.t(),
          entered_at: EnteredAt.t(),
          entered_by: EnteredBy.t(),
          posted_by: PostedBy.t(),
          reverse_document_indicator: ReverseDocumentIndicator.t(),
          reverse_document_accounting_unit: String.t(),
          reverse_document_fiscal_year: integer,
          reverse_document_accounting_document: integer,
          reverse_document_accounting_document_item: integer,
          reverse_document_accounting_period: integer,
          clearing_document_indicator: String.t(),
          clearing_document_accounting_unit: String.t(),
          clearing_document_fiscal_year: integer,
          clearing_document_accounting_document: integer,
          clearing_document_accounting_document_item: integer,
          cleairng_document_accounting_period: integer,
          reference_area: String.t(),
          reference_key: String.t(),
          general_ledger_account_transaction_type: String.t(),
          general_ledger_account: String.t(),
          vendor_transaction_type: String.t(),
          vendor: String.t(),
          customer_transaction_type: String.t(),
          customer: String.t(),
          fixed_asset_transaction_type: String.t(),
          fixed_asset: String.t(),
          payment_service_trainsaction_type: String.t(),
          payment_service: String.t(),
          profit_center_transaction_type: String.t(),
          profit_center: String.t(),
          functional_area_transaction_type: String.t(),
          functional_area: String.t(),
          cost_center_transaction_type: String.t(),
          cost_center: String.t(),
          order_transaction_type: String.t(),
          order: String.t(),
          wbs_element_transaction_type: String.t(),
          wbs_element: String.t(),
          sales_order_transaction_type: String.t(),
          sales_order: String.t(),
          sales_order_item_transaction_type: String.t(),
          sales_order_item: String.t(),
          partner_accounting_unit: String.t(),
          partner_profit_center: String.t(),
          partner_cost_center: String.t(),
          partner_functional_area: String.t(),
          accounting_unit_currency: String.t(),
          amount_in_accounting_unit_currency: integer,
          exchange_rate_type_to_accounting_unit_currency: String.t(),
          exchange_rate_to_accounting_unit_currency: integer,
          date_of_exchange_rate_to_accounting_unit_currency: Date.t(),
          transaction_currency: String.t(),
          amount_in_transaction_currency: integer,
          accounting_area_currency: String.t(),
          amount_in_accounting_area_currency: integer,
          exchange_rate_type_to_accounting_area_currency: String.t(),
          exchange_rate_to_accounting_area_currency: integer,
          date_of_exchagne_rate_to_accounting_area_currency: Date.t(),
          offsetting_general_ledger_account: String.t(),
          offsetting_vendor: String.t(),
          offsetting_customer: String.t(),
          offsetting_fixed_asset: String.t(),
          offsetting_material: String.t(),
          offsetting_bank: String.t(),
          offsetting_payment_service: String.t(),
          offsetting_cost_center: String.t(),
          offsetting_functional_area: String.t(),
          offsetting_wbs_element: String.t(),
          vat_code: String.t(),
          vat_amount_of_accounting_unit_currency: integer,
          vat_amount_of_transaction_currency: integer,
          vat_amount_of_accounting_area_currency: integer,
          vat_base_amount_of_accounting_unit_currency: integer,
          vat_base_amount_of_transaction_currency: integer,
          vat_base_amount_of_accounting_area_currency: integer
        }

  schema "accounting_document_items" do
    field(:fiscal_year, FiscalYear)
    field(:accounting_area, AccountingArea)
    field(:accounting_document_number, AccountingDocumentNumber)
    field(:accounting_unit, AccountingUnit)
    field(:accounting_document_item_number, AccountingDocumentItemNumber)
    field(:debit_credit, DebitCredit)
    field(:document_type, DocumentType)
    field(:posting_date, PostingDate)
    field(:accounting_period, AccountingPeriod)
    field(:document_date, PostingDate)
    field(:entry_date, EntryDate)
    field(:entered_at, EnteredAt)
    field(:entered_by, EnteredBy)
    field(:posted_by, PostedBy)
    field(:reverse_document_indicator, ReverseDocumentIndicator)
    field(:reverse_document_accounting_unit, :string)
    field(:reverse_document_fiscal_year, :integer)
    field(:reverse_document_accounting_document, :integer)
    field(:reverse_document_accounting_document_item, :integer)
    field(:reverse_document_accounting_period, :integer)
    field(:clearing_document_indicator, :string)
    field(:clearing_document_accounting_unit, :string)
    field(:clearing_document_fiscal_year, :integer)
    field(:clearing_document_accounting_document, :integer)
    field(:clearing_document_accounting_document_item, :integer)
    field(:cleairng_document_accounting_period, :integer)
    field(:reference_area, :string)
    field(:reference_key, :string)
    field(:general_ledger_account_transaction_type, :string)
    field(:general_ledger_account, :string)
    field(:vendor_transaction_type, :string)
    field(:vendor, :string)
    field(:customer_transaction_type, :string)
    field(:customer, :string)
    field(:fixed_asset_transaction_type, :string)
    field(:fixed_asset, :string)
    field(:payment_service_trainsaction_type, :string)
    field(:payment_service, :string)
    field(:profit_center_transaction_type, :string)
    field(:profit_center, :string)
    field(:functional_area_transaction_type, :string)
    field(:functional_area, :string)
    field(:cost_center_transaction_type, :string)
    field(:cost_center, :string)
    field(:order_transaction_type, :string)
    field(:order, :string)
    field(:wbs_element_transaction_type, :string)
    field(:wbs_element, :string)
    field(:sales_order_transaction_type, :string)
    field(:sales_order, :string)
    field(:sales_order_item_transaction_type, :string)
    field(:sales_order_item, :string)
    field(:partner_accounting_unit, :string)
    field(:partner_profit_center, :string)
    field(:partner_cost_center, :string)
    field(:partner_functional_area, :string)
    field(:accounting_unit_currency, :string)
    field(:amount_in_accounting_unit_currency, :integer)
    field(:exchange_rate_type_to_accounting_unit_currency, :string)
    field(:exchange_rate_to_accounting_unit_currency, :integer)
    field(:date_of_exchange_rate_to_accounting_unit_currency, :date)
    field(:transaction_currency, :string)
    field(:amount_in_transaction_currency, :integer)
    field(:accounting_area_currency, :string)
    field(:amount_in_accounting_area_currency, :integer)
    field(:exchange_rate_type_to_accounting_area_currency, :string)
    field(:exchange_rate_to_accounting_area_currency, :integer)
    field(:date_of_exchagne_rate_to_accounting_area_currency, :date)
    field(:offsetting_general_ledger_account, :string)
    field(:offsetting_vendor, :string)
    field(:offsetting_customer, :string)
    field(:offsetting_fixed_asset, :string)
    field(:offsetting_material, :string)
    field(:offsetting_bank, :string)
    field(:offsetting_payment_service, :string)
    field(:offsetting_cost_center, :string)
    field(:offsetting_functional_area, :string)
    field(:offsetting_wbs_element, :string)
    field(:vat_code, :string)
    field(:vat_amount_of_accounting_unit_currency, :integer)
    field(:vat_amount_of_transaction_currency, :integer)
    field(:vat_amount_of_accounting_area_currency, :integer)
    field(:vat_base_amount_of_accounting_unit_currency, :integer)
    field(:vat_base_amount_of_transaction_currency, :integer)
    field(:vat_base_amount_of_accounting_area_currency, :integer)
  end

  def changeset(accounting_document_item, params \\ %{}) do
    accounting_document_item
    |> cast(params, [
      :fiscal_year,
      :accounting_area,
      :accounting_document_number,
      :accounting_unit,
      :accounting_document_item_number,
      :debit_credit,
      :document_type,
      :posting_date,
      :accounting_period,
      :document_date,
      :entry_date,
      :entered_at,
      :entered_by,
      :posted_by,
      :reverse_document_indicator,
      :reverse_document_accounting_unit,
      :reverse_document_fiscal_year,
      :reverse_document_accounting_document,
      :reverse_document_accounting_document_item,
      :reverse_document_accounting_period,
      :clearing_document_indicator,
      :clearing_document_accounting_unit,
      :clearing_document_fiscal_year,
      :clearing_document_accounting_document,
      :clearing_document_accounting_document_item,
      :cleairng_document_accounting_period,
      :reference_area,
      :reference_key,
      :general_ledger_account_transaction_type,
      :general_ledger_account,
      :vendor_transaction_type,
      :vendor,
      :customer_transaction_type,
      :customer,
      :fixed_asset_transaction_type,
      :fixed_asset,
      :payment_service_trainsaction_type,
      :payment_service,
      :profit_center_transaction_type,
      :profit_center,
      :functional_area_transaction_type,
      :functional_area,
      :cost_center_transaction_type,
      :cost_center,
      :order_transaction_type,
      :order,
      :wbs_element_transaction_type,
      :wbs_element,
      :sales_order_transaction_type,
      :sales_order,
      :sales_order_item_transaction_type,
      :sales_order_item,
      :partner_accounting_unit,
      :partner_profit_center,
      :partner_cost_center,
      :partner_functional_area,
      :accounting_unit_currency,
      :amount_in_accounting_unit_currency,
      :exchange_rate_type_to_accounting_unit_currency,
      :exchange_rate_to_accounting_unit_currency,
      :date_of_exchange_rate_to_accounting_unit_currency,
      :transaction_currency,
      :amount_in_transaction_currency,
      :accounting_area_currency,
      :amount_in_accounting_area_currency,
      :exchange_rate_type_to_accounting_area_currency,
      :exchange_rate_to_accounting_area_currency,
      :date_of_exchagne_rate_to_accounting_area_currency,
      :offsetting_general_ledger_account,
      :offsetting_vendor,
      :offsetting_customer,
      :offsetting_fixed_asset,
      :offsetting_material,
      :offsetting_bank,
      :offsetting_payment_service,
      :offsetting_cost_center,
      :offsetting_functional_area,
      :offsetting_wbs_element,
      :vat_code,
      :vat_amount_of_accounting_unit_currency,
      :vat_amount_of_transaction_currency,
      :vat_amount_of_accounting_area_currency,
      :vat_base_amount_of_accounting_unit_currency,
      :vat_base_amount_of_transaction_currency,
      :vat_base_amount_of_accounting_area_currency
    ])
    |> unique_constraint([
      :fiscal_year,
      :accounting_document_number,
      :accounting_unit,
      :accounting_document_item_number
    ])
  end
end
