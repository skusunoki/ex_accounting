defmodule ExAccounting.Elem.OffsettingPaymentService do
  @moduledoc """
  _Offsetting Payment Service_ is the payment service of the offsetting item of the documment.
  """

  use ExAccounting.Type
  entity(:payment_service, type: :string, length: 10, description: "Offsetting Payment Service")
end
