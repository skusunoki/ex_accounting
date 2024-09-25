defmodule ExAccounting.Schema.AccountingDocumentItem do
  @moduledoc """
  _Accounting Document Item_ is atomic data object in the accounting system.
  """

  use Ecto.Schema
  import Ecto.Changeset

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
    ReverseDocumentIndicator,
    AmountInTransactionCurrency,
    ReversedDocumentAccountingDocumentItem,
    ReversedDocumentAccountingDocument,
    ReversedDocumentAccountingUnit,
    ReversedDocumentFiscalYear,
    ClearingDocumentIndicator,
    ClearingDocumentFiscalYear,
    ClearingDocumentAccountingUnit,
    ClearingDocumentAccountingDocument,
    ClearingDocumentAccountingDocumentItem,
    ClearingDocumentAccountingPeriod,
    AmountInAccountingAreaCurrency,
    AmountInAccountingUnitCurrency,
    TransactionCurrency,
    AccountingUnitCurrency,
    AccountingAreaCurrency,
    Vendor,
    VendorTransactionType,
    Customer,
    CustomerTransactionType,
    CostCenter,
    CostCenterTransactionType,
    ProfitCenter,
    ProfitCenterTransactionType,
    PaymentService,
    PaymentServiceTransactionType,
    GeneralLedgerAccount,
    GeneralLedgerAccountTransactionType,
    FixedAsset,
    FixedAssetTransactionType,
    AccountingUnitCurrency,
    ClearingDocumentAccountingPeriod,
    ClearingDocumentAccountingDocumentItem,
    ReversedDocumentAccountingPeriod,
    ReversedDocumentAccountingDocument,
    ReversedDocumentFiscalYear,
    AccountingUnit,
    FunctionalArea,
    FunctionalAreaTransactionType,
    PartnerAccountingUnit,
    PartnerProfitCenter,
    PartnerCostCenter,
    PartnerFunctionalArea,
    OffsettingGeneralLedgerAccount,
    Order,
    OrderTransactionType,
    VatAmountOfAccountingUnitCurrency,
    VatAmountOfTransactionCurrency,
    VatAmountOfAccountingAreaCurrency,
    OrderTransactionType,
    PartnerAccountingUnit,
    FunctionalArea,
    VatBaseAmountOfAccountingAreaCurrency,
    VatBaseAmountOfTransactionCurrency,
    VatBaseAmountOfAccountingUnitCurrency,
    WbsElement,
    OffsettingFunctionalArea,
    OffsettingCostCenter,
    OffsettingPaymentService,
    OffsettingFixedAsset,
    OffsettingCustomer,
    OffsettingVendor,
    WbsElementTransactionType,
    SalesOrder,
    SalesOrderTransactionType,
    SalesOrderItem,
    SalesOrderItemTransactionType,
    ExchangeRateTypeToAccountingUnitCurrency,
    ExchangeRateTypeToAccountingAreaCurrency,
    ExchangeRateToAccountingAreaCurrency,
    ExchangeRateToAccountingUnitCurrency,
    VatCode,
    DateOfExchangeRateToAccountingAreaCurrency,
    DateOfExchangeRateToAccountingUnitCurrency
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
          reverse_document_accounting_unit: ReversedDocumentAccountingUnit.t(),
          reverse_document_fiscal_year: ReversedDocumentFiscalYear.t(),
          reverse_document_accounting_document: ReversedDocumentAccountingDocument.t(),
          reverse_document_accounting_document_item: ReversedDocumentAccountingDocumentItem.t(),
          reverse_document_accounting_period: ReversedDocumentAccountingPeriod.t(),
          clearing_document_indicator: ClearingDocumentIndicator.t(),
          clearing_document_accounting_unit: ClearingDocumentAccountingUnit.t(),
          clearing_document_fiscal_year: ClearingDocumentFiscalYear.t(),
          clearing_document_accounting_document: ClearingDocumentAccountingDocument.t(),
          clearing_document_accounting_document_item: ClearingDocumentAccountingDocumentItem.t(),
          cleairng_document_accounting_period: ClearingDocumentAccountingPeriod.t(),
          reference_area: String.t(),
          reference_key: String.t(),
          general_ledger_account_transaction_type: GeneralLedgerAccountTransactionType.t(),
          general_ledger_account: GeneralLedgerAccount.t(),
          vendor_transaction_type: VendorTransactionType.t(),
          vendor: Vendor.t(),
          customer_transaction_type: CustomerTransactionType.t(),
          customer: Customer.t(),
          fixed_asset_transaction_type: FixedAssetTransactionType.t(),
          fixed_asset: FixedAsset.t(),
          payment_service_trainsaction_type: PaymentServiceTransactionType.t(),
          payment_service: PaymentService.t(),
          profit_center_transaction_type: ProfitCenterTransactionType.t(),
          profit_center: ProfitCenter.t(),
          functional_area_transaction_type: FunctionalAreaTransactionType.t(),
          functional_area: FunctionalArea.t(),
          cost_center_transaction_type: CostCenterTransactionType.t(),
          cost_center: CostCenter.t(),
          order_transaction_type: OrderTransactionType.t(),
          order: Order.t(),
          wbs_element_transaction_type: WbsElementTransactionType.t(),
          wbs_element: WbsElement.t(),
          sales_order_transaction_type: SalesOrderTransactionType.t(),
          sales_order: SalesOrder.t(),
          sales_order_item_transaction_type: SalesOrderItemTransactionType.t(),
          sales_order_item: SalesOrderItem.t(),
          partner_accounting_unit: PartnerAccountingUnit.t(),
          partner_profit_center: PartnerProfitCenter.t(),
          partner_cost_center: PartnerCostCenter.t(),
          partner_functional_area: PartnerFunctionalArea.t(),
          accounting_unit_currency: AccountingUnitCurrency.t(),
          amount_in_accounting_unit_currency: AmountInAccountingUnitCurrency.t(),
          exchange_rate_type_to_accounting_unit_currency:
            ExchangeRateTypeToAccountingUnitCurrency.t(),
          exchange_rate_to_accounting_unit_currency: ExchangeRateToAccountingUnitCurrency.t(),
          date_of_exchange_rate_to_accounting_unit_currency:
            DateOfExchangeRateToAccountingUnitCurrency.t(),
          transaction_currency: TransactionCurrency.t(),
          amount_in_transaction_currency: AmountInTransactionCurrency.t(),
          accounting_area_currency: AccountingAreaCurrency.t(),
          amount_in_accounting_area_currency: AmountInAccountingAreaCurrency.t(),
          exchange_rate_type_to_accounting_area_currency:
            ExchangeRateTypeToAccountingAreaCurrency.t(),
          exchange_rate_to_accounting_area_currency: ExchangeRateToAccountingAreaCurrency.t(),
          date_of_exchagne_rate_to_accounting_area_currency:
            DateOfExchangeRateToAccountingAreaCurrency.t(),
          offsetting_general_ledger_account: OffsettingGeneralLedgerAccount.t(),
          offsetting_vendor: OffsettingVendor.t(),
          offsetting_customer: OffsettingCustomer.t(),
          offsetting_fixed_asset: OffsettingFixedAsset.t(),
          offsetting_material: String.t(),
          offsetting_bank: String.t(),
          offsetting_payment_service: OffsettingPaymentService.t(),
          offsetting_cost_center: OffsettingCostCenter.t(),
          offsetting_functional_area: OffsettingFunctionalArea.t(),
          offsetting_wbs_element: String.t(),
          vat_code: VatCode.t(),
          vat_amount_of_accounting_unit_currency: VatAmountOfAccountingUnitCurrency.t(),
          vat_amount_of_transaction_currency: VatAmountOfAccountingUnitCurrency.t(),
          vat_amount_of_accounting_area_currency: VatAmountOfAccountingAreaCurrency.t(),
          vat_base_amount_of_accounting_unit_currency: VatBaseAmountOfAccountingUnitCurrency.t(),
          vat_base_amount_of_transaction_currency: VatBaseAmountOfTransactionCurrency.t(),
          vat_base_amount_of_accounting_area_currency: VatBaseAmountOfAccountingAreaCurrency.t()
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
    field(:reverse_document_accounting_unit, ReversedDocumentAccountingUnit)
    field(:reverse_document_fiscal_year, ReversedDocumentFiscalYear)
    field(:reverse_document_accounting_document, ReversedDocumentAccountingDocument)
    field(:reverse_document_accounting_document_item, ReversedDocumentAccountingDocumentItem)
    field(:reverse_document_accounting_period, ReversedDocumentAccountingPeriod)
    field(:clearing_document_indicator, ClearingDocumentIndicator)
    field(:clearing_document_accounting_unit, ClearingDocumentAccountingUnit)
    field(:clearing_document_fiscal_year, ClearingDocumentFiscalYear)
    field(:clearing_document_accounting_document, ClearingDocumentAccountingDocument)
    field(:clearing_document_accounting_document_item, ClearingDocumentAccountingDocumentItem)
    field(:cleairng_document_accounting_period, ClearingDocumentAccountingPeriod)
    field(:reference_area, :string)
    field(:reference_key, :string)
    field(:general_ledger_account_transaction_type, GeneralLedgerAccountTransactionType)
    field(:general_ledger_account, GeneralLedgerAccount)
    field(:vendor_transaction_type, VendorTransactionType)
    field(:vendor, Vendor)
    field(:customer_transaction_type, CustomerTransactionType)
    field(:customer, Customer)
    field(:fixed_asset_transaction_type, FixedAssetTransactionType)
    field(:fixed_asset, FixedAsset)
    field(:payment_service_trainsaction_type, PaymentServiceTransactionType)
    field(:payment_service, PaymentService)
    field(:profit_center_transaction_type, ProfitCenterTransactionType)
    field(:profit_center, ProfitCenter)
    field(:functional_area_transaction_type, FunctionalAreaTransactionType)
    field(:functional_area, FunctionalArea)
    field(:cost_center_transaction_type, CostCenterTransactionType)
    field(:cost_center, CostCenter)
    field(:order_transaction_type, OrderTransactionType)
    field(:order, Order)
    field(:wbs_element_transaction_type, WbsElementTransactionType)
    field(:wbs_element, WbsElement)
    field(:sales_order_transaction_type, SalesOrderTransactionType)
    field(:sales_order, SalesOrder)
    field(:sales_order_item_transaction_type, SalesOrderItemTransactionType)
    field(:sales_order_item, SalesOrderItem)
    field(:partner_accounting_unit, PartnerAccountingUnit)
    field(:partner_profit_center, PartnerProfitCenter)
    field(:partner_cost_center, PartnerCostCenter)
    field(:partner_functional_area, PartnerFunctionalArea)
    field(:accounting_unit_currency, AccountingUnitCurrency)
    field(:amount_in_accounting_unit_currency, AmountInAccountingUnitCurrency)

    field(
      :exchange_rate_type_to_accounting_unit_currency,
      ExchangeRateTypeToAccountingUnitCurrency
    )

    field(:exchange_rate_to_accounting_unit_currency, ExchangeRateTypeToAccountingUnitCurrency)

    field(
      :date_of_exchange_rate_to_accounting_unit_currency,
      DateOfExchangeRateToAccountingUnitCurrency
    )

    field(:transaction_currency, TransactionCurrency)
    field(:amount_in_transaction_currency, AmountInTransactionCurrency)
    field(:accounting_area_currency, AccountingAreaCurrency)
    field(:amount_in_accounting_area_currency, AmountInAccountingAreaCurrency)

    field(
      :exchange_rate_type_to_accounting_area_currency,
      ExchangeRateTypeToAccountingAreaCurrency
    )

    field(:exchange_rate_to_accounting_area_currency, ExchangeRateToAccountingAreaCurrency)

    field(
      :date_of_exchagne_rate_to_accounting_area_currency,
      DateOfExchangeRateToAccountingAreaCurrency
    )

    field(:offsetting_general_ledger_account, OffsettingGeneralLedgerAccount)
    field(:offsetting_vendor, OffsettingVendor)
    field(:offsetting_customer, OffsettingCustomer)
    field(:offsetting_fixed_asset, OffsettingFixedAsset)
    field(:offsetting_material, :string)
    field(:offsetting_bank, :string)
    field(:offsetting_payment_service, OffsettingPaymentService)
    field(:offsetting_cost_center, OffsettingCostCenter)
    field(:offsetting_functional_area, OffsettingFunctionalArea)
    field(:offsetting_wbs_element, :string)
    field(:vat_code, VatCode)
    field(:vat_amount_of_accounting_unit_currency, VatAmountOfAccountingUnitCurrency)
    field(:vat_amount_of_transaction_currency, VatAmountOfTransactionCurrency)
    field(:vat_amount_of_accounting_area_currency, VatAmountOfAccountingAreaCurrency)
    field(:vat_base_amount_of_accounting_unit_currency, VatBaseAmountOfAccountingUnitCurrency)
    field(:vat_base_amount_of_transaction_currency, VatBaseAmountOfTransactionCurrency)
    field(:vat_base_amount_of_accounting_area_currency, VatBaseAmountOfAccountingAreaCurrency)
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
