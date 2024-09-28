defmodule ExAccounting.Elem.PaymentService do
  @moduledoc """
  _Payment Service_ is identifier of a payment service.
  """

  use ExAccounting.Type
  entity(:payment_service, type: :string, length: 10)
end
