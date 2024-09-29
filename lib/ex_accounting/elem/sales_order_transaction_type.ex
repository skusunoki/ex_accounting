defmodule ExAccounting.Elem.SalesOrderTransactionType do
  @moduledoc """
  _Sales Order Transaction Type_ classifies the effects of the sales order related transactions.

  ## List of Sales Order Transaction Types

  | Code | Description             |
  | ---- | ----------------------- |
  | 001  | Creation of Sales Order |
  | 300  | Billing                 |
  | 400  | Down Payment Request    |
  | 500  | Down Payment Paid       |
  | 600  | Paid                    |
  """

  use ExAccounting.Type
  code(:sales_order_transaction_type, length: 3, description: "Sales Order Transaction Type")
end
