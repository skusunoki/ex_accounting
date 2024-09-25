defmodule ExAccounting.EmbeddedSchema.ControllingTransaction do
  use Ecto.Schema

  embedded_schema do
    field(:accounting_area, ExAccounting.Elem.AccountingArea)
    field(:accounting_unit, ExAccounting.Elem.AccountingUnit)
    field(:profit_center, ExAccounting.Elem.ProfitCenter)
    field(:fiscal_year, ExAccounting.Elem.FiscalYear)
    field(:accounting_period, ExAccounting.Elem.AccountingPeriod)
    field(:posting_date, ExAccounting.Elem.PostingDate)
    field(:cost_center, ExAccounting.Elem.CostCenter)
    field(:cost_center_transaction_type, ExAccounting.Elem.CostCenterTransactionType)
    field(:order, ExAccounting.Elem.Order)
    field(:order_transaction_type, ExAccounting.Elem.OrderTransactionType)
    field(:wbs_element, ExAccounting.Elem.WbsElement)
    field(:wbs_element_transaction_type, ExAccounting.Elem.WbsElementTransactionType)
    field(:sales_order, ExAccounting.Elem.SalesOrder)
    field(:sales_order_transaction_type, ExAccounting.Elem.SalesOrderTransactionType)
    field(:sales_order_item, ExAccounting.Elem.SalesOrderItem)
    field(:sales_order_item_transaction_type, ExAccounting.Elem.SalesOrderItemTransactionType)
    embeds_one(:transaction_value, ExAccounting.EmbeddedSchema.Money)
    embeds_one(:accounting_area_value, ExAccounting.EmbeddedSchema.Money)
    embeds_one(:accounting_unit_value, ExAccounting.EmbeddedSchema.Money)
  end
end
